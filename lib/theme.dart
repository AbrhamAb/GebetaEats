import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF18C964);
  static const Color primaryDark = Color(0xFF0EA756);
  static const Color background = Color(0xFFF9FAFB);
  static const Color text = Color(0xFF1F2933);
  static const Color muted = Color(0xFF7B828A);
  static const Color border = Color(0xFFE5E7EB);
}

ThemeData buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
    ),
    textTheme: GoogleFonts.montserratTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
      titleLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: AppColors.text,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        minimumSize: const Size.fromHeight(52),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),
  );
}
