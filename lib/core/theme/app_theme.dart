import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

/// Defines the theme configuration for the App Aya.
/// This class cannot be instantiated.
class AppTheme {
  AppTheme._();

  /// Returns the dark theme configuration for the app.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AyaColors.deepPurple,
      primaryColor: AyaColors.lavender,
      colorScheme: ColorScheme.dark(
        primary: AyaColors.lavender,
        secondary: AyaColors.turquoise,
        surface: Color(0xFF1E1D2B),
        error: AyaColors.error,
        onPrimary: AyaColors.deepPurple,
        onSecondary: Colors.white,
        onSurface: AyaColors.textPrimaryOnDark,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: AyaTextStyles.h1.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        displayMedium: AyaTextStyles.h2.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        displaySmall: AyaTextStyles.h3.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        headlineLarge: AyaTextStyles.h1.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        headlineMedium: AyaTextStyles.h2.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        headlineSmall: AyaTextStyles.h3.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        titleLarge: AyaTextStyles.labelLarge.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        titleMedium: AyaTextStyles.labelMedium.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        titleSmall: AyaTextStyles.labelSmall.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        bodyLarge: AyaTextStyles.bodyLarge.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        bodyMedium: AyaTextStyles.bodyMedium.copyWith(
          color: AyaColors.textSecondary,
        ),
        bodySmall: AyaTextStyles.bodySmall.copyWith(
          color: AyaColors.textSecondary,
        ),
        labelLarge: AyaTextStyles.labelLarge.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        labelMedium: AyaTextStyles.labelMedium.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        labelSmall: AyaTextStyles.labelSmall.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AyaColors.deepPurple,
        elevation: 0,
        titleTextStyle: AyaTextStyles.h3.copyWith(
          color: AyaColors.textPrimaryOnDark,
        ),
        iconTheme: IconThemeData(color: AyaColors.lavender),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AyaColors.lavender,
          foregroundColor: AyaColors.deepPurple,
          textStyle: AyaTextStyles.button,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMd),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AyaColors.lavender,
          textStyle: AyaTextStyles.button,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingMd,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AyaColors.lavender,
          side: BorderSide(color: AyaColors.lavender),
          textStyle: AyaTextStyles.button,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingLg,
            vertical: AppDimensions.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMd),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AyaColors.deepPurple,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMd),
          borderSide: BorderSide(color: AyaColors.softLavender),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMd),
          borderSide: BorderSide(color: AyaColors.softLavender),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMd),
          borderSide: BorderSide(color: AyaColors.lavender),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMd),
          borderSide: BorderSide(color: AyaColors.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingMd,
        ),
      ),
      cardTheme: CardThemeData(
        color: Color(0xFF1E1D2B),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLg),
        ),
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
      ),
      iconTheme: IconThemeData(color: AyaColors.softLavender, size: 24.0),
      dividerColor: AyaColors.softLavender.withAlpha((255 * 0.3).round()),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AyaColors.deepPurple,
        selectedItemColor: AyaColors.lavender,
        unselectedItemColor: AyaColors.softLavender,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
