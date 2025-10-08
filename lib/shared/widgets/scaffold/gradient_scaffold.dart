import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Scaffold with gradient background and custom status bar
class GradientScaffold extends StatelessWidget {
  /// Main content of the scaffold
  final Widget body;
  
  /// App bar widget
  final PreferredSizeWidget? appBar;
  
  /// Bottom navigation bar
  final Widget? bottomNavigationBar;
  
  /// Whether to show status bar
  
  /// Background gradient
  final Gradient? backgroundGradient;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundGradient
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundGradient ?? const LinearGradient(
            begin: Alignment(-0.15, 1.48),
            end: Alignment(1.54, 1.55),
            colors: AppColors.primaryGradient,
          ),
        ),
        child: body,
      ),
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  /// Build custom status bar

}
