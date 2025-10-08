import '../entities/user_entity.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Send OTP to the given phone number
  /// Returns verification ID for OTP verification
  Future<String> sendOtp(String phoneNumber);
  
  /// Verify OTP code with verification ID
  /// Returns user ID if verification is successful
  Future<String> verifyOtp(String verificationId, String otpCode);
  
  /// Register a new user with the given information
  /// Returns the created user entity
  Future<UserEntity> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  });
  
  /// Sign in with phone number and OTP
  /// Returns the user entity
  Future<UserEntity> signInWithPhone(String phoneNumber, String otpCode);
  
  /// Sign out the current user
  Future<void> signOut();
  
  /// Get the current authenticated user
  /// Returns null if no user is signed in
  Future<UserEntity?> getCurrentUser();
  
  /// Check if a user is currently signed in
  Future<bool> isSignedIn();
  
  /// Update user profile information
  Future<UserEntity> updateUser(UserEntity user);
  
  /// Delete user account
  Future<void> deleteUser(String userId);
}
