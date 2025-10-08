/// Application spacing system following 8pt grid
class AppSpacing {
  // Base spacing unit (8pt)
  static const double base = 8.0;
  
  // Micro spacing
  static const double xs = base * 0.5; // 4pt
  static const double sm = base * 1.0; // 8pt
  static const double md = base * 1.5; // 12pt
  static const double lg = base * 2.0; // 16pt
  static const double xl = base * 3.0; // 24pt
  static const double xxl = base * 4.0; // 32pt
  static const double xxxl = base * 6.0; // 48pt
  static const double huge = base * 8.0; // 64pt
  
  // Specific spacing
  static const double paddingXS = xs;
  static const double paddingSM = sm;
  static const double paddingMD = md;
  static const double paddingLG = lg;
  static const double paddingXL = xl;
  static const double paddingXXL = xxl;
  
  static const double marginXS = xs;
  static const double marginSM = sm;
  static const double marginMD = md;
  static const double marginLG = lg;
  static const double marginXL = xl;
  static const double marginXXL = xxl;
  
  // Gap spacing
  static const double gapXS = xs;
  static const double gapSM = sm;
  static const double gapMD = md;
  static const double gapLG = lg;
  static const double gapXL = xl;
  static const double gapXXL = xxl;
  
  // Border radius
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusRound = 50.0;
  static const double radiusCircle = 100.0;
  
  // Icon sizes
  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 40.0;
  static const double iconXXL = 48.0;
  
  // Button heights
  static const double buttonHeightSM = 32.0;
  static const double buttonHeightMD = 40.0;
  static const double buttonHeightLG = 48.0;
  static const double buttonHeightXL = 56.0;
  static const double buttonHeightXXL = 64.0;
  
  // Input heights
  static const double inputHeightSM = 32.0;
  static const double inputHeightMD = 40.0;
  static const double inputHeightLG = 48.0;
  static const double inputHeightXL = 56.0;
  
  // Card dimensions
  static const double cardPadding = lg;
  static const double cardRadius = radiusLG;
  static const double cardElevation = 2.0;
  
  // Screen padding
  static const double screenPadding = lg;
  static const double screenPaddingHorizontal = lg;
  static const double screenPaddingVertical = lg;
}
