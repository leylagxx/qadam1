import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_typography.dart';
import '../../../../shared/widgets/buttons/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _illustrationSlideAnimation;
  late Animation<double> _illustrationFadeAnimation;
  late Animation<Offset> _containerSlideAnimation;
  late Animation<double> _containerFadeAnimation;
  
  // Анимации для перехода
  late Animation<Offset> _illustrationExitAnimation;
  late Animation<Offset> _containerExitAnimation;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    print('🎬 WelcomeScreen: initState called');
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Иллюстрация: появляется сверху вниз (0.0 - 0.8)
    _illustrationSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    _illustrationFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    // Контейнер: появляется снизу вверх (0.5 - 1.0)
    _containerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
    ));

    _containerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
    ));

    // Анимации для перехода
    _illustrationExitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    ));

    _containerExitAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    ));

    // Запускаем анимацию
    _animationController.forward();
  }

  void _navigateToOnboarding() {
    if (_isExiting) return;
    
    setState(() {
      _isExiting = true;
    });
    
    // Запускаем анимацию ухода
    _animationController.forward().then((_) {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Градиентный фон
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFE8D9FF),
                  AppColors.primary.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Иллюстрация с анимацией
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return SlideTransition(
                position: _isExiting ? _illustrationExitAnimation : _illustrationSlideAnimation,
                child: FadeTransition(
                  opacity: _isExiting ? 
                    Tween<double>(begin: 1.0, end: 0.0).animate(_animationController) :
                    _illustrationFadeAnimation,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 210.h),
                      child: SvgPicture.asset(
                        'assets/images/Illustration.svg',
                        width: 280.w,
                        height: 300.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Нижний контейнер с анимацией
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: _isExiting ? _containerExitAnimation : _containerSlideAnimation,
                  child: FadeTransition(
                    opacity: _isExiting ? 
                      Tween<double>(begin: 1.0, end: 0.0).animate(_animationController) :
                      _containerFadeAnimation,
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
                          'Qadam-ға қош келдіңіз!',
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
                          'Жүрекке тыныштық, қаржыға тәртіп',
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
                          text: 'Келесі',
                          onPressed: _navigateToOnboarding,
                          width: double.infinity,
                          
                           height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

          // Кнопка "Өткізу"
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 16.h, right: 20.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.6),
                    elevation: 0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () => context.go('/phone'),
                  child: Text(
                    'Өткізу',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}