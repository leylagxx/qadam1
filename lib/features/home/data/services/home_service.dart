import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/firebase/firebase_config.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/models/goal.dart';
import '../../domain/models/lesson.dart';
import '../../domain/models/video.dart';

/// Service for home screen data management
class HomeService {
  static final FirebaseFirestore _firestore = FirebaseConfig.firestore;
  static final FirebaseAuth _auth = FirebaseConfig.auth;

  /// Get user profile
  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      print('🔑 HomeService: Getting user profile for uid: $uid');
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      
      print('🔑 HomeService: Document exists: ${doc.exists}');
      if (doc.exists) {
        final data = doc.data()!;
        print('🔑 HomeService: Document data: $data');
        final userProfile = UserProfile.fromMap(data);
        print('🔑 HomeService: UserProfile displayName: ${userProfile.displayName}');
        return userProfile;
      }
      
      // Get user from Firebase Auth if not found in Firestore
      final currentUser = _auth.currentUser;
      print('🔑 HomeService: Firebase Auth currentUser: ${currentUser?.uid}');
      print('🔑 HomeService: Firebase Auth displayName: ${currentUser?.displayName}');
      if (currentUser != null && currentUser.uid == uid) {
        final userProfile = UserProfile(
          uid: uid,
          phoneNumber: currentUser.phoneNumber ?? '+7 777 777 77 77',
          displayName: currentUser.displayName ?? 'Пайдаланушы',
          email: currentUser.email,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        print('🔑 HomeService: Created UserProfile from Firebase Auth: ${userProfile.displayName}');
        return userProfile;
      }
      
      // Return default profile if user doesn't exist
      return UserProfile(
        uid: uid,
        phoneNumber: '+7 777 777 77 77',
        displayName: 'Пайдаланушы',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      print('🔑 Error getting user profile: $e');
      
      // Try to get user from Firebase Auth as fallback
      final currentUser = _auth.currentUser;
      print('🔑 HomeService: Error fallback - Firebase Auth currentUser: ${currentUser?.uid}');
      print('🔑 HomeService: Error fallback - Firebase Auth displayName: ${currentUser?.displayName}');
      if (currentUser != null && currentUser.uid == uid) {
        final userProfile = UserProfile(
          uid: uid,
          phoneNumber: currentUser.phoneNumber ?? '+7 777 777 77 77',
          displayName: currentUser.displayName ?? 'Пайдаланушы',
          email: currentUser.email,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        print('🔑 HomeService: Error fallback - Created UserProfile: ${userProfile.displayName}');
        return userProfile;
      }
      
      // Return default profile if error occurs
      return UserProfile(
        uid: uid,
        phoneNumber: '+7 777 777 77 77',
        displayName: 'Пайдаланушы',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  /// Get user goals
  Future<List<Goal>> getUserGoals(String uid) async {
    try {
      final querySnapshot = await _firestore
          .collection('goals')
          .where('userId', isEqualTo: uid)
          .get();
      
      return querySnapshot.docs
          .map((doc) => Goal.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('🔑 Error getting user goals: $e');
      // Return empty list instead of throwing error
      return [];
    }
  }

  /// Get lessons
  Future<List<Lesson>> getLessons() async {
    try {
      final querySnapshot = await _firestore
          .collection('lessons')
          .get();
      
      if (querySnapshot.docs.isEmpty) {
        // Return mock data if no lessons exist
        return _getMockLessons();
      }
      
      return querySnapshot.docs
          .map((doc) => Lesson.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('🔑 Error getting lessons: $e');
      // Return mock data if Firestore fails
      return _getMockLessons();
    }
  }

  /// Add goal contribution
  Future<void> addGoalContribution(String goalId, double amount) async {
    try {
      final goalRef = _firestore.collection('goals').doc(goalId);
      
      await _firestore.runTransaction((transaction) async {
        final goalDoc = await transaction.get(goalRef);
        if (!goalDoc.exists) throw Exception('Goal not found');
        
        final goalData = goalDoc.data()!;
        final currentAmount = (goalData['currentAmount'] ?? 0.0).toDouble();
        final newAmount = currentAmount + amount;
        
        transaction.update(goalRef, {
          'currentAmount': newAmount,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      throw Exception('Failed to add contribution: $e');
    }
  }

  /// Create new goal
  Future<void> createGoal(Goal goal) async {
    try {
      await _firestore
          .collection('goals')
          .doc(goal.id)
          .set(goal.toMap());
    } catch (e) {
      throw Exception('Failed to create goal: $e');
    }
  }

  /// Update daily intent
  Future<void> updateDailyIntent(String intent) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');
      
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({
        'dailyIntent': intent,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update daily intent: $e');
    }
  }

  /// Get daily intent
  Future<String?> getDailyIntent() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;
      
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();
      
      if (doc.exists) {
        return doc.data()?['dailyIntent'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get videos
  Future<List<Video>> getVideos() async {
    try {
      final querySnapshot = await _firestore
          .collection('videos')
          .orderBy('createdAt', descending: true)
          .get();
      
      if (querySnapshot.docs.isEmpty) {
        // Return mock data if no videos exist
        return _getMockVideos();
      }
      
      return querySnapshot.docs
          .map((doc) => Video.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('🎬 Error getting videos: $e');
      // Return mock data if Firestore fails
      return _getMockVideos();
    }
  }

  /// Mock videos data for development
  List<Video> _getMockVideos() {
    return [
      Video(
        id: '1',
        title: 'Риф Ерлана',
        subtitle: 'Мотивация и успех',
        description: 'Вдохновляющие истории и советы от Рифа Ерлана для достижения целей',
        videoUrl: 'https://firebasestorage.googleapis.com/v0/b/qadam-1.firebasestorage.app/o/video%20(2).mp4?alt=media&token=c230b869-b816-4947-8678-d1c136c8c56f',
        thumbnailUrl: 'assets/images/rif_erlan_video.jpg',
        duration: const Duration(minutes: 45),
        isCompleted: false,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Video(
        id: '2',
        title: 'Риф Ерлана',
        subtitle: 'Личностный рост',
        description: 'Развитие личности и навыков для успешной жизни',
        videoUrl: 'https://firebasestorage.googleapis.com/v0/b/qadam-1.firebasestorage.app/o/video.mp4?alt=media&token=62919378-0e12-42ef-805f-7c0b905647c0',
        thumbnailUrl: 'assets/images/rif_erlan_video.jpg',
        duration: const Duration(minutes: 60),
        isCompleted: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Video(
        id: '3',
        title: 'Риф Ерлана',
        subtitle: 'Бизнес и предпринимательство',
        description: 'Практические советы по ведению бизнеса и предпринимательству',
        videoUrl: 'https://firebasestorage.googleapis.com/v0/b/qadam-1.firebasestorage.app/o/video%20(2).mp4?alt=media&token=c230b869-b816-4947-8678-d1c136c8c56f',
        thumbnailUrl: 'assets/images/rif_erlan_video.jpg',
        duration: const Duration(minutes: 50),
        isCompleted: false,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Video(
        id: '4',
        title: 'Риф Ерлана',
        subtitle: 'Финансовая грамотность',
        description: 'Основы управления финансами и инвестирования',
        videoUrl: 'https://firebasestorage.googleapis.com/v0/b/qadam-1.firebasestorage.app/o/video.mp4?alt=media&token=62919378-0e12-42ef-805f-7c0b905647c0',
        thumbnailUrl: 'assets/images/rif_erlan_video.jpg',
        duration: const Duration(minutes: 55),
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
    ];
  }

  /// Mock lessons data for development
  List<Lesson> _getMockLessons() {
    return [
      Lesson(
        id: '1',
        title: 'Прорыв Деньги сабағы',
        description: 'Основы финансового успеха',
        courseId: 'money_course',
        order: 1,
        totalLessons: 10,
        completedLessons: 4,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
        durationMinutes: 45,
        status: LessonStatus.inProgress,
      ),
      Lesson(
        id: '2',
        title: 'Мышление миллионера',
        description: 'Психология богатства',
        courseId: 'money_course',
        order: 2,
        totalLessons: 10,
        completedLessons: 4,
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
        updatedAt: DateTime.now(),
        durationMinutes: 60,
        status: LessonStatus.notStarted,
      ),
      Lesson(
        id: '3',
        title: 'Инвестиции для начинающих',
        description: 'Как начать инвестировать',
        courseId: 'money_course',
        order: 3,
        totalLessons: 10,
        completedLessons: 4,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now(),
        durationMinutes: 50,
        status: LessonStatus.notStarted,
      ),
    ];
  }
}
