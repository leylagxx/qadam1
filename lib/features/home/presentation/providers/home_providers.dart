import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/models/goal.dart';
import '../../domain/models/lesson.dart';
import '../../domain/models/video.dart';
import '../../data/services/home_service.dart';

/// Home service provider
final homeServiceProvider = Provider<HomeService>((ref) => HomeService());

/// Current user provider
final currentUserProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// User profile provider
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return null;
  
  final homeService = ref.read(homeServiceProvider);
  return await homeService.getUserProfile(user.uid);
});

/// Goals provider
final goalsProvider = FutureProvider<List<Goal>>((ref) async {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return [];
  
  final homeService = ref.read(homeServiceProvider);
  try {
    return await homeService.getUserGoals(user.uid);
  } catch (e) {
    print('🔑 Goals provider error: $e');
    return [];
  }
});

/// Active goals provider (not completed)
final activeGoalsProvider = Provider<List<Goal>>((ref) {
  final goals = ref.watch(goalsProvider).value ?? [];
  return goals.where((goal) => !goal.isCompleted).toList();
});

/// Lessons provider
final lessonsProvider = FutureProvider<List<Lesson>>((ref) async {
  final homeService = ref.read(homeServiceProvider);
  try {
    return await homeService.getLessons();
  } catch (e) {
    print('🔑 Lessons provider error: $e');
    return [];
  }
});

/// Current lesson progress provider
final currentLessonProgressProvider = Provider<Map<String, dynamic>>((ref) {
  final lessons = ref.watch(lessonsProvider).value ?? [];
  if (lessons.isEmpty) return {'progress': 0.0, 'completed': 0, 'total': 0};
  
  final totalLessons = lessons.length;
  final completedLessons = lessons.where((lesson) => lesson.isCompleted).length;
  final progress = totalLessons > 0 ? completedLessons / totalLessons : 0.0;
  
  return {
    'progress': progress,
    'completed': completedLessons,
    'total': totalLessons,
  };
});

/// Notifications count provider
final notificationsCountProvider = StateProvider<int>((ref) => 3);

/// Daily intent provider
final dailyIntentProvider = StateProvider<String?>((ref) => null);

/// Home screen loading state
final homeLoadingProvider = StateProvider<bool>((ref) => false);

/// Videos provider
final videosProvider = FutureProvider<List<Video>>((ref) async {
  final homeService = ref.read(homeServiceProvider);
  try {
    return await homeService.getVideos();
  } catch (e) {
    print('🎬 Videos provider error: $e');
    return [];
  }
});

/// Featured videos provider (first 3 videos)
final featuredVideosProvider = Provider<List<Video>>((ref) {
  final videosAsync = ref.watch(videosProvider);
  return videosAsync.when(
    data: (videos) => videos.take(3).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Refresh home data provider
final refreshHomeDataProvider = FutureProvider<void>((ref) async {
  ref.invalidate(userProfileProvider);
  ref.invalidate(goalsProvider);
  ref.invalidate(lessonsProvider);
  ref.invalidate(videosProvider);
});
