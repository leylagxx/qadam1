import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Application theme configuration following Material 3 design system
class AppTheme {
  /// Light theme configuration
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceVariant: AppColors.surfaceVariant,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      shadow: AppColors.shadow,
      scrim: AppColors.scrim,
      surfaceTint: AppColors.surfaceTint,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
      appBarTheme: _buildAppBarTheme(colorScheme),
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),
      textButtonTheme: _buildTextButtonTheme(colorScheme),
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),
      cardTheme: _buildCardTheme(colorScheme),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(colorScheme),
      scaffoldBackgroundColor: AppColors.background,
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),
      appBarTheme: _buildAppBarTheme(colorScheme),
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),
      textButtonTheme: _buildTextButtonTheme(colorScheme),
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),
      cardTheme: _buildCardTheme(colorScheme),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.surface,
    );
  }

  /// Build text theme with custom typography and Kazakh font support
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      displayMedium: AppTypography.displayMedium.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      displaySmall: AppTypography.displaySmall.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      headlineLarge: AppTypography.headlineLarge.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      headlineMedium: AppTypography.headlineMedium.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      headlineSmall: AppTypography.headlineSmall.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      titleLarge: AppTypography.titleLarge.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      titleMedium: AppTypography.titleMedium.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      titleSmall: AppTypography.titleSmall.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      bodyLarge: AppTypography.bodyLarge.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      bodyMedium: AppTypography.bodyMedium.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      bodySmall: AppTypography.bodySmall.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      labelLarge: AppTypography.labelLarge.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      labelMedium: AppTypography.labelMedium.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
      labelSmall: AppTypography.labelSmall.copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      ),
    );
  }

  /// Build app bar theme
  static AppBarTheme _buildAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.titleLarge.copyWith(
        color: colorScheme.onSurface,
      ),
    );
  }

  /// Build elevated button theme
  static ElevatedButtonThemeData _buildElevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingXL,
          vertical: AppSpacing.paddingLG,
        ),
        textStyle: AppTypography.buttonLarge,
        minimumSize: Size(0, AppSpacing.buttonHeightLG),
      ),
    );
  }

  /// Build outlined button theme
  static OutlinedButtonThemeData _buildOutlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingXL,
          vertical: AppSpacing.paddingLG,
        ),
        textStyle: AppTypography.buttonLarge,
        minimumSize: Size(0, AppSpacing.buttonHeightLG),
      ),
    );
  }

  /// Build text button theme
  static TextButtonThemeData _buildTextButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingLG,
          vertical: AppSpacing.paddingMD,
        ),
        textStyle: AppTypography.buttonLarge,
      ),
    );
  }

  /// Build input decoration theme
  static InputDecorationTheme _buildInputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: AppColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: AppColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMD,
        vertical: AppSpacing.paddingSM,
      ),
      hintStyle: AppTypography.bodyLarge.copyWith(
        color: AppColors.textSecondary,
      ),
      labelStyle: AppTypography.labelLarge.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  /// Build card theme
  static CardTheme _buildCardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
      elevation: AppSpacing.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      margin: EdgeInsets.all(AppSpacing.paddingSM),
    );
  }

  /// Build bottom navigation bar theme
  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme(ColorScheme colorScheme) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
}
