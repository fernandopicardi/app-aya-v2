import 'package:flutter/material.dart';

/// Defines the spacing, border radius, and shadow dimensions for the App Aya.
/// This class cannot be instantiated.
class AppDimensions {
  AppDimensions._();

  // Spacing Units
  static const double spacingXs = 4.0; // 0.5x
  static const double spacingSm = 8.0; // 1x
  static const double spacingMd = 16.0; // 2x
  static const double spacingLg = 24.0; // 3x
  static const double spacingXl = 32.0; // 4x
  static const double spacing2xl = 48.0; // 6x

  // Border Radius
  static const double borderRadiusSm = 4.0; // 0.5x
  static const double borderRadiusMd = 8.0; // 1x
  static const double borderRadiusLg = 12.0; // 1.5x
  static const double borderRadiusXl = 16.0; // 2x

  // Shadows
  static const List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.2),
      offset: Offset(0, 8),
      blurRadius: 16,
    ),
  ];

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Animation Curves
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveLinear = Curves.linear;
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
}
