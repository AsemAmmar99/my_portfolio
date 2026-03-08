/// Responsive breakpoints and layout dimensions
abstract class AppDimensions {
  // ── Breakpoints ───────────────────────────────────────────────────────────
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  // ── Section Padding ───────────────────────────────────────────────────────
  static const double sectionPaddingDesktop = 80.0;
  static const double sectionPaddingTablet = 48.0;
  static const double sectionPaddingMobile = 24.0;

  static const double sectionVerticalPadding = 100.0;
  static const double sectionVerticalPaddingMobile = 60.0;

  // ── Max Content Width ─────────────────────────────────────────────────────
  static const double maxContentWidth = 1200.0;

  // ── Nav ───────────────────────────────────────────────────────────────────
  static const double navBarHeight = 70.0;
  static const double navLogoSize = 40.0;

  // ── Cards ─────────────────────────────────────────────────────────────────
  static const double cardBorderRadius = 16.0;
  static const double cardPadding = 24.0;
  static const double projectCardWidth = 380.0;
  static const double projectCardHeight = 320.0;

  // ── Spacing Scale ─────────────────────────────────────────────────────────
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // ── Border Radius ─────────────────────────────────────────────────────────
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // ── Animation Durations ───────────────────────────────────────────────────
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 400);
  static const Duration animSlow = Duration(milliseconds: 600);
  static const Duration animXSlow = Duration(milliseconds: 900);
}
