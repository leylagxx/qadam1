import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Primary button widget following Material 3 design system
class PrimaryButton extends StatelessWidget {
  /// Button text
  final String text;
  
  /// Callback when button is pressed
  final VoidCallback? onPressed;
  
  /// Whether the button is in loading state
  final bool isLoading;
  
  /// Button width
  final double? width;
  
  /// Button height
  final double? height;
  
  /// Button style variant
  final PrimaryButtonVariant variant;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.variant = PrimaryButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppSpacing.buttonHeightLG,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(colorScheme),
          foregroundColor: _getForegroundColor(colorScheme),
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
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getForegroundColor(colorScheme),
                  ),
                ),
              )
            : Text(text),
      ),
    );
  }

  /// Get background color based on variant
  Color _getBackgroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case PrimaryButtonVariant.primary:
        return AppColors.primary;
      case PrimaryButtonVariant.secondary:
        return AppColors.secondary;
      case PrimaryButtonVariant.tertiary:
        return AppColors.tertiary;
      case PrimaryButtonVariant.error:
        return AppColors.error;
      case PrimaryButtonVariant.transparent:
        return AppColors.white.withOpacity(0.2);
    }
  }

  /// Get foreground color based on variant
  Color _getForegroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case PrimaryButtonVariant.primary:
        return AppColors.onPrimary;
      case PrimaryButtonVariant.secondary:
        return AppColors.onSecondary;
      case PrimaryButtonVariant.tertiary:
        return AppColors.onTertiary;
      case PrimaryButtonVariant.error:
        return AppColors.onError;
      case PrimaryButtonVariant.transparent:
        return AppColors.white;
    }
  }
}

/// Primary button variants
enum PrimaryButtonVariant {
  primary,
  secondary,
  tertiary,
  error,
  transparent,
}
