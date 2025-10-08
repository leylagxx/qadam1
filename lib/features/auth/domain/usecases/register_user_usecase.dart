import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import 'send_otp_usecase.dart';

/// Use case for registering a new user
class RegisterUserUseCase {
  final AuthRepository _authRepository;

  const RegisterUserUseCase(this._authRepository);

  /// Register a new user with the given information
  /// 
  /// Throws [AuthException] if registration fails
  Future<UserEntity> call({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    _validateInputs(fullName, email, phoneNumber, password);
    
    try {
      return await _authRepository.registerUser(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );
    } catch (e) {
      throw AuthException('Failed to register user: ${e.toString()}');
    }
  }

  /// Validate input parameters
  void _validateInputs(String fullName, String email, String phoneNumber, String password) {
    if (fullName.trim().isEmpty) {
      throw const AuthException('Full name cannot be empty');
    }
    
    if (fullName.length > 50) {
      throw const AuthException('Full name cannot exceed 50 characters');
    }
    
    if (email.trim().isEmpty) {
      throw const AuthException('Email cannot be empty');
    }
    
    if (!_isValidEmail(email)) {
      throw const AuthException('Invalid email format');
    }
    
    if (phoneNumber.trim().isEmpty) {
      throw const AuthException('Phone number cannot be empty');
    }
    
    if (!_isValidPhoneNumber(phoneNumber)) {
      throw const AuthException('Invalid phone number format');
    }
    
    if (password.isEmpty) {
      throw const AuthException('Password cannot be empty');
    }
    
    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters long');
    }
  }

  /// Validate email format
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  /// Validate phone number format
  bool _isValidPhoneNumber(String phoneNumber) {
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 7 && digitsOnly.length <= 15;
  }
}
