import 'package:flutter/material.dart';

/// Defines the color palette for the App Aya.
/// This class cannot be instantiated.
class AyaColors {
  AyaColors._();

  // Primary Colors
  static const Color deepPurple = Color(0xFF2A2939);
  static const Color lavender = Color(0xFFACA1EF);

  // Secondary and Accent Colors
  static const Color turquoise = Color(0xFF78C7B4);
  static const Color softLavender = Color(0xFF575C84);

  // Neutral Colors
  static const Color surface = Color(0xFFF8F8FF);
  static const Color textPrimaryOnDark = Colors.white;
  static const Color textSecondaryOnDark = Color(0xFF575C84);

  // State Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);
  static const Color info = Color(0xFF2196F3);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF2A2939), // deepPurple
      Color(0xFF575C84), // softLavender
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [
      Color(0xFF78C7B4), // turquoise
      Color(0xFFACA1EF), // lavender
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Overlays and Transparencies
  static Color get darkOverlay => Colors.black.withAlpha((255 * 0.3).round());
  static Color get lightOverlay => Colors.white.withAlpha((255 * 0.1).round());
  static Color get glassyOverlay =>
      Colors.white.withAlpha((255 * 0.05).round());
}
