import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application typography system following Material 3 design system
class AppTypography {
  // Font families
  static const String primaryFontFamily = 'Mulish';
  static const String secondaryFontFamily = 'Exo2';
  static const String tertiaryFontFamily = 'Mulish';
  
  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  
  // Helper method to create text styles
  static TextStyle _createTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required double letterSpacing,
    required double height,
  }) {
    return GoogleFonts.mulish(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
  
  // Display styles
  static TextStyle get displayLarge => _createTextStyle(
    fontSize: 57,
    fontWeight: regular,
    letterSpacing: -0.25,
    height: 1.12,
  );
  
  static TextStyle get displayMedium => _createTextStyle(
    fontSize: 45,
    fontWeight: regular,
    letterSpacing: 0,
    height: 1.16,
  );
  
  static TextStyle get displaySmall => _createTextStyle(
    fontSize: 36,
    fontWeight: regular,
    letterSpacing: 0,
    height: 1.22,
  );
  
  // Headline styles
  static TextStyle get headlineLarge => _createTextStyle(
    fontSize: 32,
    fontWeight: regular,
    letterSpacing: 0,
    height: 1.25,
  );
  
  static TextStyle get headlineMedium => _createTextStyle(
    fontSize: 28,
    fontWeight: regular,
    letterSpacing: 0,
    height: 1.29,
  );
  
  static TextStyle get headlineSmall => _createTextStyle(
    fontSize: 24,
    fontWeight: regular,
    letterSpacing: 0,
    height: 1.33,
  );
  
  // Title styles
  static TextStyle get titleLarge => _createTextStyle(
    fontSize: 22,
    fontWeight: regular,
    letterSpacing: 0,
    height: 1.27,
  );
  
  static TextStyle get titleMedium => _createTextStyle(
    fontSize: 16,
    fontWeight: medium,
    letterSpacing: 0.15,
    height: 1.50,
  );
  
  static TextStyle get titleSmall => _createTextStyle(
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  // Body styles
  static TextStyle get bodyLarge => _createTextStyle(
    fontSize: 16,
    fontWeight: regular,
    letterSpacing: 0.5,
    height: 1.50,
  );
  
  static TextStyle get bodyMedium => _createTextStyle(
    fontSize: 14,
    fontWeight: regular,
    letterSpacing: 0.25,
    height: 1.43,
  );
  
  static TextStyle get bodySmall => _createTextStyle(
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  // Label styles
  static TextStyle get labelLarge => _createTextStyle(
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  static TextStyle get labelMedium => _createTextStyle(
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: 0.5,
    height: 1.33,
  );
  
  static TextStyle get labelSmall => _createTextStyle(
    fontSize: 11,
    fontWeight: medium,
    letterSpacing: 0.5,
    height: 1.45,
  );
  
  // Custom brand styles
  static TextStyle get brandLarge => _createTextStyle(
    fontSize: 52,
    fontWeight: bold,
    letterSpacing: -0.5,
    height: 1.0,
  );
  
  static TextStyle get brandMedium => _createTextStyle(
    fontSize: 28,
    fontWeight: bold,
    letterSpacing: 0,
    height: 1.2,
  );
  
  static TextStyle get brandSmall => _createTextStyle(
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: 0,
    height: 1.33,
  );
  
  // Button styles
  static TextStyle get buttonLarge => _createTextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    letterSpacing: 0.1,
    height: 1.25,
  );
  
  static TextStyle get buttonMedium => _createTextStyle(
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  static TextStyle get buttonSmall => _createTextStyle(
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: 0.5,
    height: 1.33,
  );
  
  // Caption styles
  static TextStyle get caption => _createTextStyle(
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  static TextStyle get overline => _createTextStyle(
    fontSize: 10,
    fontWeight: medium,
    letterSpacing: 1.5,
    height: 1.6,
  );
}