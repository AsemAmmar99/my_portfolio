import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  // ── Dark Theme ─────────────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.bgSecondary,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: _buildTextTheme(
        primary: AppColors.textPrimary,
        secondary: AppColors.textSecondary,
        muted: AppColors.textMuted,
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      cardTheme: const CardThemeData(
        color: AppColors.bgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.bgBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.bgBorder,
        thickness: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      inputDecorationTheme: _buildInputDecorationTheme(
        fillColor: AppColors.bgCard,
        borderColor: AppColors.bgBorder,
        hintColor: AppColors.textMuted,
        labelColor: AppColors.textSecondary,
      ),
    );
  }

  // ── Light Theme ────────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBgPrimary,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightBgSecondary,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
      ),
      textTheme: _buildTextTheme(
        primary: AppColors.lightTextPrimary,
        secondary: AppColors.lightTextSecondary,
        muted: AppColors.lightTextMuted,
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(),
      cardTheme: const CardThemeData(
        color: AppColors.lightBgCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.lightBgBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBgBorder,
        thickness: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBgPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextPrimary,
        ),
      ),
      inputDecorationTheme: _buildInputDecorationTheme(
        fillColor: AppColors.lightBgCard,
        borderColor: AppColors.lightBgBorder,
        hintColor: AppColors.lightTextMuted,
        labelColor: AppColors.lightTextSecondary,
      ),
    );
  }

  // ── Shared Text Theme ──────────────────────────────────────────────────────
  static TextTheme _buildTextTheme({
    required Color primary,
    required Color secondary,
    required Color muted,
  }) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 72, fontWeight: FontWeight.w700, color: primary, height: 1.1, letterSpacing: -1.5),
      displayMedium: GoogleFonts.poppins(
        fontSize: 56, fontWeight: FontWeight.w700, color: primary, height: 1.2, letterSpacing: -1.0),
      displaySmall: GoogleFonts.poppins(
        fontSize: 40, fontWeight: FontWeight.w600, color: primary, height: 1.25),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32, fontWeight: FontWeight.w700, color: primary, height: 1.3),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28, fontWeight: FontWeight.w600, color: primary, height: 1.35),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 22, fontWeight: FontWeight.w600, color: primary, height: 1.4),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18, fontWeight: FontWeight.w600, color: primary),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w500, color: primary),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, color: secondary),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, color: secondary, height: 1.75),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w400, color: secondary, height: 1.7),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w600, color: primary, letterSpacing: 1.2),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w500, color: secondary, letterSpacing: 0.8),
    );
  }

  // ── Shared Button Themes ───────────────────────────────────────────────────
  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    );
  }

  // ── Shared Input Decoration ────────────────────────────────────────────────
  static InputDecorationTheme _buildInputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
    required Color hintColor,
    required Color labelColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      hintStyle: GoogleFonts.poppins(fontSize: 14, color: hintColor),
      labelStyle: GoogleFonts.poppins(fontSize: 14, color: labelColor),
    );
  }
}
