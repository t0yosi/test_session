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

  /// Headline - Large
  static TextStyle headlineLarge(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).textTheme.headlineLarge?.color,
      );

  /// Headline - Medium
  static TextStyle headlineMedium(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
      );

  /// Title - Large
  static TextStyle titleLarge(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color ?? Theme.of(context).textTheme.titleLarge?.color,
      );

  /// Body - Large
  static TextStyle bodyLarge(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
      );

  /// Body - Medium
  static TextStyle bodyMedium(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
      );

  /// Label - Large
  static TextStyle labelLarge(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color ?? Theme.of(context).textTheme.labelLarge?.color,
      );

  /// Label - Medium
  static TextStyle labelMedium(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color ?? Theme.of(context).textTheme.labelMedium?.color,
      );

  /// Caption
  static TextStyle caption(BuildContext context, {Color? color}) =>
      inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color ?? Theme.of(context).textTheme.bodySmall?.color,
      );
}
