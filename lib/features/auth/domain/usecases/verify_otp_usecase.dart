import '../repositories/auth_repository.dart';
import 'send_otp_usecase.dart';

/// Use case for verifying OTP code
class VerifyOtpUseCase {
  final AuthRepository _authRepository;

  const VerifyOtpUseCase(this._authRepository);

  /// Verify OTP code with verification ID
  /// 
  /// Throws [AuthException] if verification fails
  Future<String> call(String verificationId, String otpCode) async {
    if (verificationId.isEmpty) {
      throw const AuthException('Verification ID cannot be empty');
    }
    
    if (otpCode.isEmpty) {
      throw const AuthException('OTP code cannot be empty');
    }
    
    if (!_isValidOtpCode(otpCode)) {
      throw const AuthException('Invalid OTP code format');
    }
    
    try {
      return await _authRepository.verifyOtp(verificationId, otpCode);
    } catch (e) {
      throw AuthException('Failed to verify OTP: ${e.toString()}');
    }
  }

  /// Validate OTP code format
  bool _isValidOtpCode(String otpCode) {
    // Check if OTP contains only digits and has correct length
    return RegExp(r'^\d{5}$').hasMatch(otpCode);
  }
}
