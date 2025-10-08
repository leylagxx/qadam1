import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/firebase/firebase_config.dart';

/// Service for phone number authentication
class PhoneAuthService {
  static final FirebaseAuth _auth = FirebaseConfig.auth;

  /// Send OTP to phone number
  Future<String> sendOtp(String phoneNumber, Function(String) onVerificationIdReceived) async {
    try {
      // Format phone number - support international numbers
      String formattedPhone = phoneNumber;
      
      // If no country code, assume Kazakhstan (+7)
      if (!phoneNumber.startsWith('+')) {
        formattedPhone = '+7${phoneNumber.replaceAll(RegExp(r'[^\d]'), '')}';
      }
      
      print('🔑 Sending OTP to: $formattedPhone');

      // For web platform, we need to handle reCAPTCHA differently
      if (kIsWeb) {
        return await _sendOtpWeb(formattedPhone, onVerificationIdReceived);
      } else {
        return await _sendOtpMobile(formattedPhone, onVerificationIdReceived);
      }
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  /// Send OTP for mobile platforms
  Future<String> _sendOtpMobile(String phoneNumber, Function(String) onVerificationIdReceived) async {
    print('🔑 Starting Firebase verifyPhoneNumber for: $phoneNumber');
    
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('✅ Auto verification completed');
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('❌ Verification failed: ${e.message}');
        throw Exception('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        print('🔑 SMS sent successfully, verificationId: $verificationId');
        onVerificationIdReceived(verificationId); // ОБЯЗАТЕЛЬНО вызываем callback
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('⏰ Auto retrieval timeout: $verificationId');
        onVerificationIdReceived(verificationId);
      },
      timeout: const Duration(seconds: 60),
    );

    print('🔑 Firebase verifyPhoneNumber completed');
    return 'OTP sent successfully';
  }

  /// Send OTP for web platform
  Future<String> _sendOtpWeb(String phoneNumber, Function(String) onVerificationIdReceived) async {
    try {
      print('🔑 Web platform - sending real SMS to: $phoneNumber');
      
      // Use the same Firebase method as mobile
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print('🔑 Web verification failed: ${e.message}');
          throw Exception('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          print('🔑 Web Firebase codeSent callback: $verificationId');
          onVerificationIdReceived(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('🔑 Web codeAutoRetrievalTimeout: $verificationId');
          onVerificationIdReceived(verificationId);
        },
        timeout: const Duration(seconds: 60),
      );
      
      return 'OTP sent successfully';
    } catch (e) {
      print('🔑 Web OTP error: $e');
      throw Exception('Web OTP sending failed: $e');
    }
  }

  /// Verify OTP code
  Future<UserCredential> verifyOtp(String otp, String verificationId) async {
    try {
      print('🔑 Verifying OTP: $otp with verificationId: $verificationId');
      
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      print('🔑 Credential created, signing in...');

      final userCredential = await _auth.signInWithCredential(credential);
      print('🔑 OTP verification successful, user: ${userCredential.user?.uid}');
      return userCredential;
    } catch (e) {
      print('🔑 OTP verification failed: $e');
      throw Exception('Failed to verify OTP: $e');
    }
  }

  /// Resend OTP
  Future<String> resendOtp(String phoneNumber, Function(String) onVerificationIdReceived) async {
    return await sendOtp(phoneNumber, onVerificationIdReceived);
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
