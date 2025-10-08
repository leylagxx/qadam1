import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/firebase/firebase_config.dart';

/// User data model
class UserModel {
  final String uid;
  final String phoneNumber;
  final String? displayName;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
    this.email,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      displayName: map['displayName'],
      email: map['email'],
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      isActive: map['isActive'] ?? true,
    );
  }
}

/// Service for user data management
class UserService {
  static final FirebaseFirestore _firestore = FirebaseConfig.firestore;
  static const String _usersCollection = 'users';

  /// Create user profile in Firestore
  Future<UserModel> createUser(User user) async {
    try {
      final userModel = UserModel(
        uid: user.uid,
        phoneNumber: user.phoneNumber ?? '',
        displayName: user.displayName,
        email: user.email,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection(_usersCollection)
          .doc(user.uid)
          .set(userModel.toMap());

      return userModel;
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  /// Get user by UID
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  /// Update user profile
  Future<void> updateUser(String uid, Map<String, dynamic> updates) async {
    try {
      updates['updatedAt'] = DateTime.now().toIso8601String();
      
      await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .update(updates);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  /// Check if user exists
  Future<bool> userExists(String uid) async {
    try {
      final doc = await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  /// Delete user
  Future<void> deleteUser(String uid) async {
    try {
      await _firestore
          .collection(_usersCollection)
          .doc(uid)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
