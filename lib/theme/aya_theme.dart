import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AyaColors {
  // Base Colors
  static const Color background = Color(0xFF2A2939);
  static const Color surface = Color(0xFF474C72);
  static const Color backgroundGradientEnd = Color(0xFF474C72);

  // Accent Colors
  static const Color lavenderSoft = Color(0xFF575C84);
  static const Color lavenderVibrant = Color(0xFFACA1EF);
  static const Color turquoise = Color(0xFF78C7B4);
  static const Color softBlue = Color(0xFF73BDDA);
  static const Color cardGradientStart = Color(0xFF8DB1D1);
  static const Color cardGradientEnd = Color(0xFF78C7B4);

  // Text Colors
  static const Color textPrimary = Color(0xFFF8F8FF);
  static const Color textSecondary = Color(0xFFF8F8FF);

  // Colors with Opacity
  static const Color textPrimary80 = Color(0xCCF8F8FF); // 80% opacity
  static const Color textPrimary60 = Color(0x99F8F8FF); // 60% opacity
  static const Color textPrimary50 = Color(0x80F8F8FF); // 50% opacity
  static const Color textPrimary40 = Color(0x66F8F8FF); // 40% opacity
  static const Color lavenderSoft30 = Color(0x4D575C84); // 30% opacity
  static const Color overlayDark = Color(0x66000000); // 40% opacity
  static const Color overlayLight = Color(0x66FFFFFF); // 40% opacity
}

class AyaTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: AyaColors.turquoise,
        secondary: AyaColors.lavenderVibrant,
        surface: AyaColors.surface,
        error: Colors.red.shade300,
        onPrimary: AyaColors.textPrimary,
        onSecondary: AyaColors.textPrimary,
        onSurface: AyaColors.textPrimary,
        onError: AyaColors.textPrimary,
      ),

      // Scaffold
      scaffoldBackgroundColor: AyaColors.background,

      // Typography
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          color: AyaColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          color: AyaColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.roboto(
          color: AyaColors.textPrimary80,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: GoogleFonts.roboto(
          color: AyaColors.textPrimary60,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: AyaColors.textPrimary,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: AyaColors.lavenderSoft,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AyaColors.turquoise,
          foregroundColor: AyaColors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AyaColors.backgroundGradientEnd,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AyaColors.lavenderSoft),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AyaColors.lavenderSoft),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AyaColors.lavenderVibrant),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.roboto(
          color: AyaColors.textPrimary50,
          fontSize: 16,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AyaColors.background,
        selectedItemColor: AyaColors.turquoise,
        unselectedItemColor: AyaColors.textPrimary50,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: AyaColors.backgroundGradientEnd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: GoogleFonts.roboto(
          color: AyaColors.textPrimary,
          fontSize: 16,
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AyaColors.lavenderSoft30,
        thickness: 1,
        space: 24,
      ),
    );
  }
}
