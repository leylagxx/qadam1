import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

/// Remote data source for authentication operations
abstract class AuthRemoteDataSource {
  /// Send OTP to the given phone number
  Future<String> sendOtp(String phoneNumber);
  
  /// Verify OTP code with verification ID
  Future<String> verifyOtp(String verificationId, String otpCode);
  
  /// Register a new user
  Future<UserModel> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  });
  
  /// Sign in with phone number and OTP
  Future<UserModel> signInWithPhone(String phoneNumber, String otpCode);
  
  /// Sign out the current user
  Future<void> signOut();
  
  /// Get the current authenticated user
  Future<UserModel?> getCurrentUser();
  
  /// Check if a user is currently signed in
  Future<bool> isSignedIn();
  
  /// Update user profile information
  Future<UserModel> updateUser(UserModel user);
  
  /// Delete user account
  Future<void> deleteUser(String userId);
}

/// Firebase implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  const AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  @override
  Future<String> sendOtp(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto-verification completed
        },
        verificationFailed: (FirebaseAuthException e) {
          throw AuthException('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Code sent successfully
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout
        },
        timeout: const Duration(seconds: 60),
      );
      
      // Return a mock verification ID for now
      // In a real implementation, this would be handled differently
      return 'mock_verification_id';
    } catch (e) {
      throw AuthException('Failed to send OTP: ${e.toString()}');
    }
  }

  @override
  Future<String> verifyOtp(String verificationId, String otpCode) async {
    try {
      // Create phone auth credential
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      
      // Sign in with credential
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      if (userCredential.user == null) {
        throw AuthException('Failed to verify OTP');
      }
      
      return userCredential.user!.uid;
    } catch (e) {
      throw AuthException('Failed to verify OTP: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Create user with email and password
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (userCredential.user == null) {
        throw AuthException('Failed to create user');
      }
      
      final user = userCredential.user!;
      final now = DateTime.now();
      
      // Create user model
      final userModel = UserModel(
        id: user.uid,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        isEmailVerified: user.emailVerified,
        isPhoneVerified: false,
        createdAt: now,
        updatedAt: now,
      );
      
      // Save user to Firestore
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toMap());
      
      return userModel;
    } catch (e) {
      throw AuthException('Failed to register user: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithPhone(String phoneNumber, String otpCode) async {
    try {
      // This would typically involve phone authentication
      // For now, we'll use a mock implementation
      final now = DateTime.now();
      
      final userModel = UserModel(
        id: 'mock_user_id',
        fullName: 'Mock User',
        email: 'mock@example.com',
        phoneNumber: phoneNumber,
        isEmailVerified: false,
        isPhoneVerified: true,
        createdAt: now,
        updatedAt: now,
      );
      
      return userModel;
    } catch (e) {
      throw AuthException('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException('Failed to sign out: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;
      
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return null;
      
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      throw AuthException('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      return _firebaseAuth.currentUser != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .update(user.toMap());
      
      return user;
    } catch (e) {
      throw AuthException('Failed to update user: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      // Delete user document from Firestore
      await _firestore.collection('users').doc(userId).delete();
      
      // Delete user from Firebase Auth
      await _firebaseAuth.currentUser?.delete();
    } catch (e) {
      throw AuthException('Failed to delete user: ${e.toString()}');
    }
  }
}

/// Authentication exception
class AuthException implements Exception {
  final String message;
  
  const AuthException(this.message);
  
  @override
  String toString() => 'AuthException: $message';
}
