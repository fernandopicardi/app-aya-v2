import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class AyaColors {
  // Base Colors
  static const Color background = Color(0xFF2A2939);
  static const Color surface = Color(0xFF474C72);
  static const Color backgroundGradientEnd = Color(0xFF474C72);

  // Accent Colors
  static const Color primary = Color(0xFF78C7B4); // turquoise
  static const Color secondary = Color(0xFFACA1EF); // lavenderVibrant
  static const Color accent = Color(0xFF73BDDA); // softBlue
  static const Color lavenderSoft = Color(0xFF575C84);
  static const Color lavenderVibrant = Color(0xFFACA1EF);
  static const Color turquoise = Color(0xFF78C7B4);
  static const Color softBlue = Color(0xFF73BDDA);
  static const Color cardGradientStart = Color(0xFF8DB1D1);
  static const Color cardGradientEnd = Color(0xFF78C7B4);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF78C7B4); // turquoise
  static const Color buttonSecondary = Color(0xFFACA1EF); // lavenderVibrant
  static const Color buttonDisabled = Color(0xFF575C84); // lavenderSoft

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

  // New Colors with Opacity
  static const Color surface70 = Color(0xB3474C72); // 70% opacity
  static const Color surface50 = Color(0x80474C72); // 50% opacity
  static const Color surface20 = Color(0x33474C72); // 20% opacity
  static const Color lavenderVibrant30 = Color(0x4DACA1EF); // 30% opacity
  static const Color turquoise30 = Color(0x4D78C7B4); // 30% opacity
  static const Color black60 = Color(0x99000000); // 60% opacity
  static const Color black70 = Color(0xB3000000); // 70% opacity
  static const Color black50 = Color(0x80000000);
  static const Color white30 = Color(0x4DFFFFFF); // 30% opacity
  static const Color white85 = Color(0xD9FFFFFF); // 85% opacity
  static const Color white40 = Color(0x66FFFFFF);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, backgroundGradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [cardGradientStart, cardGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphism-specific colors
  static const Color glassBackground = Color(0x1A474C72); // 10% opacity
  static const Color glassBorder = Color(0x1AF8F8FF); // 10% opacity
  static const Color glassHighlight = Color(0x1AFFFFFF); // 10% opacity
  static const Color glassShadow = Color(0x40000000); // 25% opacity
  static const Color glassInnerBorder = Color(0x0DFFFFFF); // 5% opacity
}

class AyaTypography {
  // Scale factors for different screen sizes
  static const double _mobileScale = 1.0;
  static const double _tabletScale = 1.2;
  static const double _desktopScale = 1.4;

  // Line Heights
  static const double _tightLineHeight = 1.2;
  static const double _normalLineHeight = 1.5;
  static const double _relaxedLineHeight = 1.75;

  // Letter Spacing
  static const double _tightLetterSpacing = -0.5;
  static const double _normalLetterSpacing = 0.0;
  static const double _wideLetterSpacing = 0.5;

  // Font Weights
  static const FontWeight _regular = FontWeight.w400;
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _semibold = FontWeight.w600;
  static const FontWeight _bold = FontWeight.w700;

  static double _getScaledFontSize(double size, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double scale = _mobileScale;

    if (width >= 1200) {
      scale = _desktopScale;
    } else if (width >= 768) {
      scale = _tabletScale;
    }

    return size * scale;
  }

  static TextTheme getTextTheme(BuildContext context) {
    final baseTextTheme =
        GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

    return baseTextTheme.copyWith(
      // Display styles (largest text, used for hero sections)
      displayLarge: TextStyle(
        fontSize: _getScaledFontSize(48, context),
        fontWeight: _bold,
        height: _tightLineHeight,
        letterSpacing: _tightLetterSpacing,
        color: AyaColors.textPrimary,
        shadows: [
          Shadow(
            color: AyaColors.black60,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      displayMedium: TextStyle(
        fontSize: _getScaledFontSize(40, context),
        fontWeight: _bold,
        height: _tightLineHeight,
        letterSpacing: _tightLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: _getScaledFontSize(36, context),
        fontWeight: _semibold,
        height: _tightLineHeight,
        letterSpacing: _tightLetterSpacing,
        color: AyaColors.textPrimary,
      ),

      // Headline styles (used for section titles)
      headlineLarge: TextStyle(
        fontSize: _getScaledFontSize(32, context),
        fontWeight: _semibold,
        height: _tightLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: _getScaledFontSize(28, context),
        fontWeight: _semibold,
        height: _tightLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: _getScaledFontSize(24, context),
        fontWeight: _semibold,
        height: _tightLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary,
      ),

      // Title styles (used for card titles, list items)
      titleLarge: TextStyle(
        fontSize: _getScaledFontSize(20, context),
        fontWeight: _semibold,
        height: _normalLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: _getScaledFontSize(18, context),
        fontWeight: _medium,
        height: _normalLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: _getScaledFontSize(16, context),
        fontWeight: _medium,
        height: _normalLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary,
      ),

      // Body styles (used for main content)
      bodyLarge: TextStyle(
        fontSize: _getScaledFontSize(16, context),
        fontWeight: _regular,
        height: _relaxedLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: _getScaledFontSize(14, context),
        fontWeight: _regular,
        height: _relaxedLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary80,
      ),
      bodySmall: TextStyle(
        fontSize: _getScaledFontSize(12, context),
        fontWeight: _regular,
        height: _relaxedLineHeight,
        letterSpacing: _normalLetterSpacing,
        color: AyaColors.textPrimary60,
      ),

      // Label styles (used for buttons, form fields)
      labelLarge: TextStyle(
        fontSize: _getScaledFontSize(16, context),
        fontWeight: _medium,
        height: _normalLineHeight,
        letterSpacing: _wideLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: _getScaledFontSize(14, context),
        fontWeight: _medium,
        height: _normalLineHeight,
        letterSpacing: _wideLetterSpacing,
        color: AyaColors.textPrimary,
      ),
      labelSmall: TextStyle(
        fontSize: _getScaledFontSize(12, context),
        fontWeight: _medium,
        height: _normalLineHeight,
        letterSpacing: _wideLetterSpacing,
        color: AyaColors.textPrimary60,
      ),
    );
  }
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

      // Enhanced Scaffold
      scaffoldBackgroundColor: AyaColors.background,

      // Enhanced Typography
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),

      // Enhanced AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          color: AyaColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          shadows: [
            Shadow(
              color: AyaColors.black60,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: AyaColors.textPrimary,
          shadows: [
            Shadow(
              color: AyaColors.black60,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),

      // Enhanced Card Theme
      cardTheme: ThemeData.dark().cardTheme.copyWith(
            color: AyaColors.glassBackground,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),

      // Enhanced Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AyaColors.turquoise.withValues(alpha: 0.9),
          foregroundColor: AyaColors.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                color: AyaColors.black60,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),

      // Enhanced Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AyaColors.glassBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AyaColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AyaColors.glassBorder),
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

      // Enhanced Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AyaColors.glassBackground,
        selectedItemColor: AyaColors.turquoise,
        unselectedItemColor: AyaColors.textPrimary50,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Enhanced Dialog Theme
      dialogTheme: ThemeData.dark().dialogTheme.copyWith(
            backgroundColor: AyaColors.glassBackground,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            titleTextStyle: GoogleFonts.inter(
              color: AyaColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: AyaColors.black60,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            contentTextStyle: GoogleFonts.inter(
              color: AyaColors.textPrimary,
              fontSize: 16,
              shadows: [
                Shadow(
                  color: AyaColors.black60,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),

      // Enhanced Divider Theme
      dividerTheme: DividerThemeData(
        color: AyaColors.glassBorder,
        thickness: 1,
        space: 24,
      ),

      // Enhanced Icon Theme
      iconTheme: IconThemeData(
        color: AyaColors.textPrimary,
        shadows: [
          Shadow(
            color: AyaColors.black60,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
