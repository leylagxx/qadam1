import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/phone_signin_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/success_modal.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/lessons_screen.dart';
import '../../features/home/presentation/screens/tools_screen.dart';
import '../../features/home/presentation/screens/chat_screen.dart';

/// Application routes configuration
class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String phone = '/phone';
  static const String otp = '/otp';
  static const String success = '/success';
  static const String register = '/register';
  static const String home = '/home';
  static const String lessons = '/lessons';
  static const String tools = '/tools';
  static const String chat = '/chat';
}

/// Application router configuration
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) {
        print('🎬 Router: Building SplashScreen');
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.welcome,
      name: 'welcome',
      builder: (context, state) {
        print('🎬 Router: Building WelcomeScreen');
        return const WelcomeScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.phone,
      name: 'phone',
      builder: (context, state) => const PhoneSigninScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      name: 'otp',
      builder: (context, state) {
        print('🎬 Router: Building OtpScreen');
        return const OtpScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.success,
      name: 'success',
      builder: (context, state) => const SuccessModal(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.lessons,
      name: 'lessons',
      builder: (context, state) => const LessonsScreen(),
    ),
    GoRoute(
      path: AppRoutes.tools,
      name: 'tools',
      builder: (context, state) => const ToolsScreen(),
    ),
    GoRoute(
      path: AppRoutes.chat,
      name: 'chat',
      builder: (context, state) => const ChatScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'The page you are looking for does not exist.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go(AppRoutes.splash),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);
