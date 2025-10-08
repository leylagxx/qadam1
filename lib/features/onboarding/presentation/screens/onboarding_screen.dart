import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_typography.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/scaffold/gradient_scaffold.dart';

/// Onboarding screen with man and chart illustration
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _illustrationEnterAnimation;
  late Animation<Offset> _containerEnterAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    print('🎬 OnboardingScreen: initState called');
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Иллюстрация приходит справа
    _illustrationEnterAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Контейнер приходит слева
    _containerEnterAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Запускаем анимацию
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('🎨 OnboardingScreen: build called');
    return GradientScaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // Верхняя часть с иллюстрацией и фоном
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Простой фон без градиента
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                  ),

                  // Иллюстрация с анимацией входа справа
                  Positioned(
                    top: 50.h,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _illustrationEnterAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SvgPicture.asset(
                          'assets/images/Illustration2.svg',
                          width: 450.w,
                          height: 500.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Нижний фиолетовый контейнер с анимацией входа слева
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _containerEnterAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: double.infinity,
                    height: 350.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 36.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Заголовок с красивым отступом
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            'Қаржылық дағдыларыңызды дамытыңыз',
                            textAlign: TextAlign.center,
                            style: AppTypography.headlineLarge.copyWith(
                              color: AppColors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Разделительная линия
                        Container(
                          width: 60.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Подзаголовок с красивым отступом
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            'Ниетіңізді іспен толықтырыңыз',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.white.withOpacity(0.9),
                              fontSize: 16.sp,
                              height: 1.4,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 40.h),
                        
                        // Кнопка с красивым отступом
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: PrimaryButton(
                            text: 'Бастау',
                            onPressed: () => context.go('/phone'),
                            width: double.infinity,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}