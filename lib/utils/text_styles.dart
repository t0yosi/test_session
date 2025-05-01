import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  /// Base Inter text style generator
  static TextStyle inter({
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  /// Base Avenir Next LT Pro text style generator
  static TextStyle avenir({
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    // First try to load from assets (if you've added custom font files)
    try {
      return TextStyle(
        fontFamily: 'Avenir LT Pro',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontStyle: fontStyle,
      );
    } catch (e) {
      // Fallback to Poppins if Avenir not available
      return GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontStyle: fontStyle,
      );
    }
  }

  // ----------------------------
  // Headline Styles
  // ----------------------------

  /// Headline - Large
  static TextStyle headlineLarge(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir 
      ? avenir(
          fontSize: 32,
          fontWeight: FontWeight.w800, // Avenir Heavy
          color: color ?? Theme.of(context).textTheme.headlineLarge?.color,
        )
      : inter(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: color ?? Theme.of(context).textTheme.headlineLarge?.color,
        );

  /// Headline - Medium
  static TextStyle headlineMedium(BuildContext context, {Color? color, bool useAvenir = false}) =>
    useAvenir
      ? avenir(
          fontSize: 24,
          fontWeight: FontWeight.w800, // Avenir Heavy
          color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
        )
      : inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
        );

  // ----------------------------
  // Title Styles
  // ----------------------------

  /// Title - Large
  static TextStyle titleLarge(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 20,
          fontWeight: FontWeight.w700, // Avenir Bold
          color: color ?? Theme.of(context).textTheme.titleLarge?.color,
        )
      : inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: color ?? Theme.of(context).textTheme.titleLarge?.color,
        );

  /// Title - Larger
  static TextStyle titleLarger(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 20,
          fontWeight: FontWeight.w800, // Avenir Heavy
          color: color ?? Theme.of(context).textTheme.titleLarge?.color,
        )
      : inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: color ?? Theme.of(context).textTheme.titleLarge?.color,
        );

  // ----------------------------
  // Body Styles
  // ----------------------------

  /// Body - Head
  static TextStyle bodyHead(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 16,
          fontWeight: FontWeight.w800, // Avenir Heavy
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        )
      : inter(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        );

  /// Body - Large
  static TextStyle bodyLarge(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 16,
          fontWeight: FontWeight.w700, // Avenir Bold
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        )
      : inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        );

  /// Body - Base
  static TextStyle bodyBase(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 16,
          fontWeight: FontWeight.w500, // Avenir Medium
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        )
      : inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        );

  /// Body - Medium
  static TextStyle bodyMedium(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 14,
          fontWeight: FontWeight.w600, // Avenir Demi
          color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        )
      : inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        );

  // ----------------------------
  // Label Styles
  // ----------------------------

  /// Label - Large
  static TextStyle labelLarge(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 14,
          fontWeight: FontWeight.w500, // Avenir Medium
          color: color ?? Theme.of(context).textTheme.labelLarge?.color,
        )
      : inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color ?? Theme.of(context).textTheme.labelLarge?.color,
        );

  /// Label - Base
  static TextStyle labelBase(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 14,
          fontWeight: FontWeight.w400, // Avenir Book
          color: color ?? Theme.of(context).textTheme.labelLarge?.color,
        )
      : inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: color ?? Theme.of(context).textTheme.labelLarge?.color,
        );

  /// Label - Medium
  static TextStyle labelMedium(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 12,
          fontWeight: FontWeight.w500, // Avenir Medium
          color: color ?? Theme.of(context).textTheme.labelMedium?.color,
        )
      : inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color ?? Theme.of(context).textTheme.labelMedium?.color,
        );

  /// Label - Small
  static TextStyle labelSmall(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 12,
          fontWeight: FontWeight.w400, // Avenir Book
          color: color ?? Theme.of(context).textTheme.labelMedium?.color,
        )
      : inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color ?? Theme.of(context).textTheme.labelMedium?.color,
        );

  // ----------------------------
  // Caption Styles
  // ----------------------------

  /// Caption
  static TextStyle caption(BuildContext context, {Color? color, bool useAvenir = false}) => 
    useAvenir
      ? avenir(
          fontSize: 12,
          fontWeight: FontWeight.w400, // Avenir Book
          color: color ?? Theme.of(context).textTheme.bodySmall?.color,
        )
      : inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: color ?? Theme.of(context).textTheme.bodySmall?.color,
        );
}