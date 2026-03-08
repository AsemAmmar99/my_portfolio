import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Responsive layout helper widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.mobileBreakpoint &&
      MediaQuery.of(context).size.width < AppDimensions.tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.tabletBreakpoint;

  static double sectionPadding(BuildContext context) {
    if (isMobile(context)) return AppDimensions.sectionPaddingMobile;
    if (isTablet(context)) return AppDimensions.sectionPaddingTablet;
    return AppDimensions.sectionPaddingDesktop;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppDimensions.tabletBreakpoint) {
          return desktop;
        } else if (constraints.maxWidth >= AppDimensions.mobileBreakpoint) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}

/// Constrained content width wrapper
class ContentWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const ContentWrapper({
    super.key,
    required this.child,
    this.maxWidth = AppDimensions.maxContentWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveLayout.sectionPadding(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: hPad),
          child: child,
        ),
      ),
    );
  }
}

/// Gradient divider line used below section headers
class GradientDivider extends StatelessWidget {
  final double width;
  final double height;

  const GradientDivider({
    super.key,
    this.width = 60,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
        ),
      ),
    );
  }
}

/// Glass morphism card container
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? backgroundColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = AppDimensions.radiusLg,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.bgCard : AppColors.lightBgCard;
    final cardBorder = isDark ? AppColors.bgBorder : AppColors.lightBgBorder;
    return Container(
      padding: padding ?? const EdgeInsets.all(AppDimensions.lg),
      decoration: BoxDecoration(
        color: backgroundColor ?? cardBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 40,
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Tech stack chip label
class TechChip extends StatelessWidget {
  final String label;
  final Color? color;

  const TechChip({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.xs,
      ),
      decoration: BoxDecoration(
        color: (color ?? AppColors.primary).withOpacity(0.12),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        border: Border.all(
          color: (color ?? AppColors.primary).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color ?? AppColors.primary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// CTA / action button with gradient fill
class GradientButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool outlined;

  const GradientButton({
    super.key,
    required this.label,
    this.icon,
    required this.onTap,
    this.outlined = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDimensions.animFast,
          transform: Matrix4.identity()..scale(_hovered ? 1.04 : 1.0),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: widget.outlined
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  border: Border.all(color: AppColors.primary, width: 1.5),
                  color: _hovered
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  gradient: LinearGradient(
                    colors: _hovered
                        ? [AppColors.primaryLight, AppColors.primary]
                        : AppColors.primaryGradient,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : null,
                ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 18,
                  color: widget.outlined ? AppColors.primary : Colors.white,
                ),
                const SizedBox(width: AppDimensions.sm),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.outlined ? AppColors.primary : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
