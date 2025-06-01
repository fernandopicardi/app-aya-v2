import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the typography styles for the App Aya.
/// This class cannot be instantiated.
class AyaTextStyles {
  AyaTextStyles._();

  // Font Families
  static const String fontFamilyInter = 'Inter';
  static const String fontFamilyOpenSans = 'Open Sans';

  // Display Styles (H1, H2, H3)
  static TextStyle get h1 => GoogleFonts.openSans(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static TextStyle get h2 => GoogleFonts.openSans(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static TextStyle get h3 => GoogleFonts.openSans(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Body Styles
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Label Styles
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  // Button Text
  static TextStyle get button => GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // Caption
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}
