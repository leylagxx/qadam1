import '../repositories/auth_repository.dart';

/// Use case for sending OTP to a phone number
class SendOtpUseCase {
  final AuthRepository _authRepository;

  const SendOtpUseCase(this._authRepository);

  /// Send OTP to the given phone number
  /// 
  /// Throws [AuthException] if sending fails
  Future<String> call(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      throw const AuthException('Phone number cannot be empty');
    }
    
    if (!_isValidPhoneNumber(phoneNumber)) {
      throw const AuthException('Invalid phone number format');
    }
    
    try {
      return await _authRepository.sendOtp(phoneNumber);
    } catch (e) {
      throw AuthException('Failed to send OTP: ${e.toString()}');
    }
  }

  /// Validate phone number format
  bool _isValidPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    // Check if it's a valid length (7-15 digits)
    return digitsOnly.length >= 7 && digitsOnly.length <= 15;
  }
}

/// Authentication exception
class AuthException implements Exception {
  final String message;
  
  const AuthException(this.message);
  
  @override
  String toString() => 'AuthException: $message';
}
