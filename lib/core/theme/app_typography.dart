import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the typography styles for the App Aya.
/// This class cannot be instantiated.
class AyaTextStyles {
  AyaTextStyles._();

  // Font Families
  static const String fontFamilyInter = 'Inter';
  static const String fontFamilyOpenSans = 'Open Sans';

  // Title Styles
  static final TextStyle h1 = GoogleFonts.openSans(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final TextStyle h2 = GoogleFonts.openSans(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final TextStyle h3 = GoogleFonts.openSans(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Body Styles
  static final TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Label Styles
  static final TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static final TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Button Style
  static final TextStyle button = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Caption Style
  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );
}
