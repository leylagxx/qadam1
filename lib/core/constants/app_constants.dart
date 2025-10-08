/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Qadam1';
  static const String appVersion = '1.0.0';
  
  // Design System
  static const double designWidth = 393.0;
  static const double designHeight = 852.0;
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // API
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String onboardingCompletedKey = 'onboarding_completed';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int otpLength = 5;
  
  // Phone Number
  static const String defaultCountryCode = '+7';
  static const String kazakhstanCountryCode = 'KZ';
}
