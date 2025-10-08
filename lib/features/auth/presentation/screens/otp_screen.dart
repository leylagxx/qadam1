import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_typography.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/scaffold/gradient_scaffold.dart';
import '../../../../shared/widgets/inputs/otp_input.dart';
import '../../data/providers/auth_providers.dart';
import '../../data/services/phone_auth_service.dart';
import '../../data/services/user_service.dart';

/// OTP verification screen
class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  int _resendCountdown = 60;
  String _currentOtp = '';

  @override
  void initState() {
    super.initState();
    print('🔑 OtpScreen: initState called');
    
    // Check verificationId immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final verificationId = ref.read(verificationIdProvider);
      print('🔑 OtpScreen: verificationId on init: $verificationId');
    });
    
    _startCountdown();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    if (!mounted) return;
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
        _startCountdown();
      }
    });
  }

  void _verifyOtp() async {
    // Count only non-empty characters
    final filledDigits = _currentOtp.replaceAll(' ', '').length;
    if (filledDigits != 6) {
      _showSnackBar('6 цифрлық кодты енгізіңіз');
      return;
    }

    // Get verification ID from global state
    final verificationId = ref.read(verificationIdProvider);
    print('🔑 Current verificationId: $verificationId');
    if (verificationId == null) {
      _showSnackBar('Қате: SMS коды табылмады. Қайта жіберіңіз.');
      return;
    }

    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      print('🔑 Starting OTP verification with: $_currentOtp');
      final phoneAuthService = ref.read(phoneAuthServiceProvider);
      final userService = ref.read(userServiceProvider);
      
      // Verify OTP
      print('🔑 Calling phoneAuthService.verifyOtp...');
      final userCredential = await phoneAuthService.verifyOtp(_currentOtp, verificationId);
      print('🔑 OTP verification successful, user: ${userCredential.user?.uid}');
      
      // Check if user exists in Firestore
      print('🔑 Checking if user exists in Firestore...');
      try {
        final userExists = await userService.userExists(userCredential.user!.uid);
        print('🔑 User exists: $userExists');
        
        if (!userExists) {
          // Create new user profile
          print('🔑 Creating new user profile...');
          await userService.createUser(userCredential.user!);
          print('🔑 User profile created successfully');
        }
      } catch (e) {
        print('🔑 Firestore error: $e');
        print('🔑 Error type: ${e.runtimeType}');
        print('🔑 Error details: ${e.toString()}');
        // Continue without Firestore for now
        print('🔑 Continuing without Firestore...');
      }
      
      if (mounted) {
        print('🔑 Navigation to register screen...');
        _showSnackBar('Сәтті расталды!');
        context.go('/register');
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Қате: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _resendOtp() async {
    if (_resendCountdown > 0) return;
    
    try {
      final phoneAuthService = ref.read(phoneAuthServiceProvider);
      final phoneNumber = ref.read(phoneNumberProvider);
      
      if (phoneNumber == null) {
        _showSnackBar('Қате: Телефон нөмірі табылмады');
        return;
      }
      
      await phoneAuthService.resendOtp(phoneNumber, (verificationId) {
        // Update verification ID
        ref.read(verificationIdProvider.notifier).state = verificationId;
      });
      
      setState(() {
        _resendCountdown = 60;
      });
      _startCountdown();
      
      _showSnackBar('SMS-код қайта жіберілді');
    } catch (e) {
      _showSnackBar('Қате: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('🔑 OtpScreen: build called');
    return GradientScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  children: [
                    // Back button
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            context.go('/phone');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // Main content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Аккаунтты растаңыз',
                      style: AppTypography.headlineLarge.copyWith(
                        color: AppColors.black,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    
                    // Instructions
                    Text(
                      'Телефон нөміріңізге SMS арқылы код жібердік.',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    
                    Text(
                      'Сол кодты енгізіп растаңыз',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 16.sp,
                      ),
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // OTP input
                    Center(
                      child: OtpInput(
                        length: 6,
                        onChanged: (value) {
                          _currentOtp = value;
                          if (value.length == 6) {
                            _verifyOtp();
                          }
                        },
                      ),
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Resend code
                    Center(
                      child: TextButton(
                        onPressed: _resendCountdown == 0 ? _resendOtp : null,
                        child: Text(
                          _resendCountdown > 0 
                              ? 'Қайта жіберу (${_resendCountdown}с)'
                              : 'Код келмеді ме? Қайта жіберу',
                          style: AppTypography.bodyMedium.copyWith(
                            color: _resendCountdown > 0 
                                ? AppColors.textTertiary
                                : AppColors.primary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // Verify button
                    PrimaryButton(
                      text: 'Қазір растау',
                      onPressed: _isLoading ? null : _verifyOtp,
                      width: double.infinity,
                      height: 70,
                      isLoading: _isLoading,
                    ),
                    
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}