import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../blocs/navigation/navigation_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';

class PortfolioNavBar extends StatelessWidget {
  final List<GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const PortfolioNavBar({
    super.key,
    required this.sectionKeys,
    required this.scrollController,
  });

  void _scrollToSection(int index) {
    final ctx = sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, navState) {
        final bool isDesktop = ResponsiveLayoutHelper.isDesktop(context);

        return AnimatedContainer(
          duration: AppDimensions.animNormal,
          height: AppDimensions.navBarHeight,
          decoration: BoxDecoration(
            color: navState.isScrolled ? Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95) : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: navState.isScrolled
                    ? AppColors.bgBorder
                    : Colors.transparent,
                width: 1,
              ),
            ),
            boxShadow: navState.isScrolled
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                    )
                  ]
                : null,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop
                      ? AppDimensions.sectionPaddingDesktop
                      : AppDimensions.sectionPaddingMobile,
                ),
                child: Row(
                  children: [
                    // â”€â”€ Logo â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    _LogoWidget(onTap: () => _scrollToSection(0)),
                    const Spacer(),

                    // â”€â”€ Theme Toggle + Nav Links (Desktop) or Hamburger â”€â”€â”€â”€â”€
                    const _ThemeToggleButton(),
                    const SizedBox(width: AppDimensions.sm),
                    if (isDesktop)
                      _DesktopNavLinks(
                        activeIndex: navState.activeIndex,
                        onTap: _scrollToSection,
                      )
                    else
                      _MobileMenuButton(
                        sectionKeys: sectionKeys,
                        onScrollTo: _scrollToSection,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Animated theme toggle button (sun â†” moon)
class _ThemeToggleButton extends StatefulWidget {
  const _ThemeToggleButton();

  @override
  State<_ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<_ThemeToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _rotation;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _rotation = Tween<double>(begin: 0, end: 0.5)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      _ctrl.reverse();
    } else {
      _ctrl.forward();
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        child: GestureDetector(
          onTap: () =>
              context.read<ThemeBloc>().add(const ToggleThemeEvent()),
          child: AnimatedContainer(
            duration: AppDimensions.animFast,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(
                color: _hovered
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : Colors.transparent,
              ),
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: _rotation,
                builder: (_, child) => Transform.rotate(
                  angle: _rotation.value * 3.14159,
                  child: child,
                ),
                child: AnimatedSwitcher(
                  duration: AppDimensions.animFast,
                  transitionBuilder: (child, anim) =>
                      FadeTransition(opacity: anim, child: child),
                  child: Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    key: ValueKey(isDark),
                    color: isDark
                        ? AppColors.textSecondary
                        : AppColors.warning,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoWidget extends StatefulWidget {
  final VoidCallback onTap;
  const _LogoWidget({required this.onTap});

  @override
  State<_LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<_LogoWidget> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.glassBg : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(
              color: _hovered ? AppColors.glassBorder : Colors.transparent,
            ),
          ),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: AppColors.primaryGradient,
            ).createShader(bounds),
            child: const Text(
              '< AA />',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopNavLinks extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _DesktopNavLinks({required this.activeIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        AppConstants.navSections.length,
        (index) => _NavLink(
          label: AppConstants.navSections[index],
          isActive: activeIndex == index,
          onTap: () => onTap(index),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: AppDimensions.animFast,
                style: TextStyle(
                  color: active ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: AppDimensions.animFast,
                height: 2,
                width: active ? 20 : 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  gradient: const LinearGradient(colors: AppColors.primaryGradient),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final List<GlobalKey> sectionKeys;
  final ValueChanged<int> onScrollTo;

  const _MobileMenuButton({required this.sectionKeys, required this.onScrollTo});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
      onPressed: () => _showMobileDrawer(context),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _MobileDrawer(onScrollTo: (i) {
        Navigator.pop(context);
        Future.delayed(
          const Duration(milliseconds: 300),
          () => onScrollTo(i),
        );
      }),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final ValueChanged<int> onScrollTo;
  const _MobileDrawer({required this.onScrollTo});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: AppColors.bgBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ...List.generate(
                AppConstants.navSections.length,
                (i) => ListTile(
                  title: Text(
                    AppConstants.navSections[i],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  leading: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                  onTap: () => onScrollTo(i),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveLayoutHelper {
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.tabletBreakpoint;
}

