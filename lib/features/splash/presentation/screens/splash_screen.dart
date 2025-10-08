import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_typography.dart';
import '../../../../shared/widgets/scaffold/gradient_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    print('🎬 SplashScreen: initState called');
    _startSplashTimer();
  }

  void _startSplashTimer() {
    print('🎬 SplashScreen: Starting splash timer');
    Future.delayed(const Duration(seconds: 3), () {
      if (!_navigated && mounted) {
        _navigated = true;
        print('🎬 SplashScreen: Timer completed, navigating to welcome');
        if (mounted) {
          try {
            context.pushReplacement('/welcome');
          } catch (e) {
            print('🎬 SplashScreen: Navigation error: $e');
            context.go('/welcome');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('🎬 SplashScreen: build called');
    return GradientScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Простой логотип без анимации
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(60.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.trending_up,
                      size: 60.w,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Q-ADÂM',
                    style: AppTypography.brandLarge.copyWith(
                      color: AppColors.white,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Performance by Qadam',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.white.withOpacity(0.8),
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'v1.0',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.white.withOpacity(0.6),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // Простой индикатор загрузки
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Простой текст без анимации
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                'Бүгінгі қадамыңыз — білім мен береке жолына\nбастайтын ниет.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.white.withOpacity(0.9),
                  fontSize: 14.sp,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}