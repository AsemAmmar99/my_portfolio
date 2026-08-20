import 'package:flutter/material.dart';

/// Centralized color palette for the portfolio
abstract class AppColors {
  // Primary accent — Electric Blue (shared across both themes)
  static const Color primary = Color(0xFF00B4D8);
  static const Color primaryLight = Color(0xFF48CAE4);
  static const Color primaryDark = Color(0xFF0077B6);

  // Secondary accent — Deep Teal
  static const Color secondary = Color(0xFF023E8A);
  static const Color secondaryLight = Color(0xFF0096C7);

  // ── Dark Mode ─────────────────────────────────────────────────────────────
  static const Color bgPrimary = Color(0xFF0A0E1A);
  static const Color bgSecondary = Color(0xFF0F1629);
  static const Color bgCard = Color(0xFF141B2D);
  static const Color bgCardHover = Color(0xFF1A2340);
  static const Color bgBorder = Color(0xFF1E2A45);

  static const Color glassBg = Color(0x1400B4D8);
  static const Color glassBorder = Color(0x3000B4D8);

  static const Color textPrimary = Color(0xFFE0E6F0);
  static const Color textSecondary = Color(0xFF8892A4);
  static const Color textAccent = Color(0xFF00B4D8);
  static const Color textMuted = Color(0xFF4A5568);

  // ── Light Mode (Shiny Purple Complementary) ───────────────────────────────
  static const Color lightBgPrimary = Color(0xFFF5F2F9); // Soft, professional light lavender tint
  static const Color lightBgSecondary = Color(0xFFEFEAF6); // Subtle lavender surface
  static const Color lightBgCard = Color(0xFFFFFFFF); // Crisp white
  static const Color lightBgCardHover = Color(0xFFFAF7FD);
  static const Color lightBgBorder = Color(0xFFE5DEEE); // Clean, subtle border

  static const Color lightGlassBg = Color(0x147B2CBF);
  static const Color lightGlassBorder = Color(0x307B2CBF);

  static const Color lightTextPrimary = Color(0xFF1A0B2E); // Deep purple-charcoal for titles
  static const Color lightTextSecondary = Color(0xFF4A4A4A); // High-contrast readable body text
  static const Color lightTextMuted = Color(0xFF6E6A78);

  static const Color lightPrimary = Color(0xFF7B2CBF); // Rich, professional purple
  static const Color lightPrimaryLight = Color(0xFF9D4EDD);
  static const Color lightPrimaryDark = Color(0xFF5A189A);

  // ── Status ────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF38B000);
  static const Color warning = Color(0xFFFFC300);
  static const Color error = Color(0xFFEF233C);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const List<Color> heroGradient = [
    Color(0xFF0A0E1A),
    Color(0xFF0F1629),
    Color(0xFF0A1628),
  ];

  static const List<Color> lightHeroGradient = [
    Color(0xFFF4F7FB),
    Color(0xFFEBF0F8),
    Color(0xFFDDE8F5),
  ];

  static const List<Color> primaryGradient = [
    Color(0xFF00B4D8),
    Color(0xFF0077B6),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF141B2D),
    Color(0xFF0F1629),
  ];

  static const List<Color> lightCardGradient = [
    Color(0xFFFFFFFF),
    Color(0xFFEBF0F8),
  ];
}
