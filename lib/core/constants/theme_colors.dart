import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Theme-aware color helper — returns the correct color set for the current brightness.
/// Use this in widgets instead of hardcoded AppColors dark-only values.
class ThemeColors {
  final bool isDark;

  const ThemeColors._(this.isDark);

  factory ThemeColors.of(BuildContext context) {
    return ThemeColors._(Theme.of(context).brightness == Brightness.dark);
  }

  // ── Backgrounds ───────────────────────────────────────────────────────────
  Color get bgPrimary => isDark ? AppColors.bgPrimary : AppColors.lightBgPrimary;
  Color get bgSecondary => isDark ? AppColors.bgSecondary : AppColors.lightBgSecondary;
  Color get bgCard => isDark ? AppColors.bgCard : AppColors.lightBgCard;
  Color get bgCardHover => isDark ? AppColors.bgCardHover : AppColors.lightBgCardHover;
  Color get bgBorder => isDark ? AppColors.bgBorder : AppColors.lightBgBorder;

  // ── Glass ─────────────────────────────────────────────────────────────────
  Color get glassBg => isDark ? AppColors.glassBg : AppColors.lightGlassBg;
  Color get glassBorder => isDark ? AppColors.glassBorder : AppColors.lightGlassBorder;

  // ── Text ──────────────────────────────────────────────────────────────────
  Color get textPrimary => isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
  Color get textSecondary => isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;
  Color get textMuted => isDark ? AppColors.textMuted : AppColors.lightTextMuted;

  // ── Shared (same in both themes) ──────────────────────────────────────────
  Color get accent => AppColors.primary;
  Color get accentLight => AppColors.primaryLight;
  Color get accentDark => AppColors.primaryDark;
  Color get success => AppColors.success;
  Color get warning => AppColors.warning;
  Color get error => AppColors.error;
  List<Color> get primaryGradient => AppColors.primaryGradient;
}
