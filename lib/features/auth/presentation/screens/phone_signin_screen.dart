import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_typography.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../data/providers/auth_providers.dart';
import '../../data/services/phone_auth_service.dart';

/// Onboarding / Phone Sign-in Screen
class PhoneSigninScreen extends ConsumerStatefulWidget {
  const PhoneSigninScreen({super.key});

  @override
  ConsumerState<PhoneSigninScreen> createState() => _PhoneSigninScreenState();
}

class _PhoneSigninScreenState extends ConsumerState<PhoneSigninScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  void _sendOtp() async {
    if (_phoneController.text.isEmpty) {
      _showSnackBar('Телефон нөмірін енгізіңіз');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final phoneAuthService = ref.read(phoneAuthServiceProvider);
      final phoneNumber = _phoneController.text;
      
      print('🔑 Attempting to send OTP to: $phoneNumber');
      
      // Save phone number
      ref.read(phoneNumberProvider.notifier).state = phoneNumber;
      
      // Add timeout for SMS sending
      await Future.any([
        phoneAuthService.sendOtp(phoneNumber, (verificationId) {
          // Save verification ID when received
          print('🔑 Received verificationId: $verificationId');
          if (mounted) {
            ref.read(verificationIdProvider.notifier).state = verificationId;
            print('🔑 Saved verificationId to state');
            
            // Navigate to OTP screen after saving verificationId
            try {
              context.go('/otp');
              print('🔑 Navigation to OTP successful');
            } catch (e) {
              print('🔑 Navigation error: $e');
              context.push('/otp');
            }
          }
        }),
        Future.delayed(const Duration(seconds: 30), () {
          throw Exception('SMS sending timeout');
        }),
      ]);
      
      print('🔑 SMS sent successfully');
    } catch (e) {
      if (mounted) {
        _showSnackBar('Қате: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
    return Scaffold(
      body: Container(
        // 🌈 Градиентный фон на весь экран
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFEAD9FF), // светло-фиолетовый
              AppColors.primary, // насыщенный фиолетовый
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),

              // 🎨 Иллюстрация
              SvgPicture.asset(
                'assets/images/Illustration3.svg',
                width: 260.w,
                height: 240.h,
              ),

              // 👇 Фиолетовый контейнер без зазора
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 32.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Заголовок
                    Text(
                      'Бүгінгі қадамыңыз – ертеңгі табысыңыз',
                      textAlign: TextAlign.center,
                      style: AppTypography.headlineLarge.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Подзаголовок
                    Text(
                      'Qadam сізге дағдыларды үйренуге, бақылауға және дамуға қарапайым әрі ақылды көмектеседі',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.white.withOpacity(0.85),
                        fontSize: 14.sp,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Поле ввода телефона
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '🇰🇿 +7',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.black, fontSize: 16.sp),
                              decoration: InputDecoration(
                                hintText: '777 777 77 77',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                  top: 12.h,
                                  bottom: 12.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Кнопка
                    PrimaryButton(
                      text: 'SMS-код',
                      onPressed: _isLoading ? null : _sendOtp,
                      width: double.infinity,
                      height: 70,
                      isLoading: _isLoading,
                    ),
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