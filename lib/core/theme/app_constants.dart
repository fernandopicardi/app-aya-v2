import 'package:flutter/material.dart';

/// Constants for the app's design system
class AppConstants {
  // Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing56 = 56.0;
  static const double spacing64 = 64.0;

  // Border Radius
  static const double radius4 = 4.0;
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius20 = 20.0;
  static const double radius24 = 24.0;
  static const double radius32 = 32.0;
  static const double radiusPill = 999.0;

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Elevation
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation8 = 8.0;
  static const double elevation16 = 16.0;

  // Icon Sizes
  static const double iconSize16 = 16.0;
  static const double iconSize20 = 20.0;
  static const double iconSize24 = 24.0;
  static const double iconSize32 = 32.0;
  static const double iconSize40 = 40.0;
  static const double iconSize48 = 48.0;

  // Font Sizes
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  static const double fontSize36 = 36.0;
  static const double fontSize40 = 40.0;
  static const double fontSize48 = 48.0;

  // Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightLoose = 1.8;

  // Letter Spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingLoose = 0.5;

  // Opacity
  static const double opacity0 = 0.0;
  static const double opacity25 = 0.25;
  static const double opacity50 = 0.5;
  static const double opacity75 = 0.75;
  static const double opacity100 = 1.0;

  // Z-Index
  static const int zIndex0 = 0;
  static const int zIndex10 = 10;
  static const int zIndex20 = 20;
  static const int zIndex30 = 30;
  static const int zIndex40 = 40;
  static const int zIndex50 = 50;
  static const int zIndexAuto = -1;

  // Breakpoints
  static const double breakpointXs = 0.0;
  static const double breakpointSm = 600.0;
  static const double breakpointMd = 960.0;
  static const double breakpointLg = 1280.0;
  static const double breakpointXl = 1920.0;

  // Container Max Widths
  static const double containerMaxWidthSm = 600.0;
  static const double containerMaxWidthMd = 960.0;
  static const double containerMaxWidthLg = 1280.0;
  static const double containerMaxWidthXl = 1920.0;

  // Aspect Ratios
  static const double aspectRatio1x1 = 1.0;
  static const double aspectRatio4x3 = 4.0 / 3.0;
  static const double aspectRatio16x9 = 16.0 / 9.0;
  static const double aspectRatio21x9 = 21.0 / 9.0;

  // Border Widths
  static const double borderWidth0 = 0.0;
  static const double borderWidth1 = 1.0;
  static const double borderWidth2 = 2.0;
  static const double borderWidth4 = 4.0;
  static const double borderWidth8 = 8.0;

  // Shadows
  static const Map<String, dynamic> shadowSmall = {
    'color': Color.fromRGBO(0, 0, 0, 0.1),
    'offset': Offset(0, 2),
    'blurRadius': 4,
  };

  static const Map<String, dynamic> shadowMedium = {
    'color': Color.fromRGBO(0, 0, 0, 0.15),
    'offset': Offset(0, 4),
    'blurRadius': 8,
  };

  static const Map<String, dynamic> shadowLarge = {
    'color': Color.fromRGBO(0, 0, 0, 0.2),
    'offset': Offset(0, 8),
    'blurRadius': 16,
  };

  // Transitions
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveLinear = Curves.linear;
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
}
