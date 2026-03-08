import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_dimensions.dart';
import '../widgets/common/common_widgets.dart';
import '../widgets/common/section_widgets.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onProjectsTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;
  late Animation<double> _bgAnim;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _bgAnim = CurvedAnimation(parent: _bgController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = ResponsiveLayout.isMobile(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height,
        minWidth: size.width,
      ),
      child: Stack(
        children: [
          // ── Animated Gradient Background ─────────────────────────────────
          AnimatedBuilder(
            animation: _bgAnim,
            builder: (_, __) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.lerp(
                      const Alignment(-0.6, -0.4),
                      const Alignment(0.6, 0.4),
                      _bgAnim.value,
                    )!,
                    radius: 1.4,
                    colors: isDark
                        ? const [
                            Color(0xFF0D2137),
                            AppColors.bgPrimary,
                            AppColors.bgPrimary,
                          ]
                        : const [
                            Color(0xFFCDE8F5),
                            AppColors.lightBgPrimary,
                            AppColors.lightBgPrimary,
                          ],
                    stops: const [0, 0.55, 1],
                  ),
                ),
              );
            },
          ),

          // ── Glowing Orb (top right) ───────────────────────────────────────
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _bgAnim,
              builder: (_, __) => Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary
                          .withValues(alpha: 0.08 + _bgAnim.value * 0.04),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Glowing Orb (bottom left) ─────────────────────────────────────
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primaryDark.withValues(alpha: 0.07),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Grid Pattern Overlay ──────────────────────────────────────────
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),

          // ── Main Content (Expandable) ─────────────────────────────────────
          SafeArea(
            child: Center(
              child: ContentWrapper(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: isMobile ? 48 : 0,
                    bottom: 100, // Make sure there's room for the scroll indicator
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      AnimatedSection(
                        sectionId: 'hero-greeting',
                        child: _buildGreeting(context),
                      ),
                      const SizedBox(height: AppDimensions.md),
                      AnimatedSection(
                        sectionId: 'hero-name',
                        delay: const Duration(milliseconds: 150),
                        child: _buildName(context, isMobile),
                      ),
                      const SizedBox(height: AppDimensions.md),
                      AnimatedSection(
                        sectionId: 'hero-title',
                        delay: const Duration(milliseconds: 300),
                        child: _buildAnimatedTitle(context, isMobile),
                      ),
                      const SizedBox(height: AppDimensions.xl),
                      AnimatedSection(
                        sectionId: 'hero-subtitle',
                        delay: const Duration(milliseconds: 450),
                        child: _buildSubtitle(context, isMobile),
                      ),
                      const SizedBox(height: AppDimensions.xxl),
                      AnimatedSection(
                        sectionId: 'hero-cta',
                        delay: const Duration(milliseconds: 600),
                        child: _buildCTAButtons(isMobile),
                      ),
                      const SizedBox(height: AppDimensions.xl),
                      AnimatedSection(
                        sectionId: 'hero-social',
                        delay: const Duration(milliseconds: 750),
                        child: _buildSocialLinks(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // â”€â”€ Scroll indicator â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: _ScrollIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'ðŸ‘‹  Hello, I\'m',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      AppConstants.fullName,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 40 : 72,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [
                  isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
                  AppColors.primary
                ],
                stops: const [0.5, 1.0],
              ).createShader(const Rect.fromLTWH(0, 0, 600, 80)),
          ),
    );
  }

  Widget _buildAnimatedTitle(BuildContext context, bool isMobile) {
    return Row(
      children: [
        Text(
          'I\'m a  ',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: isMobile ? 20 : 28,
                color: AppColors.textSecondary,
              ),
        ),
        AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(
              'Senior Flutter Developer',
              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: isMobile ? 20 : 28,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
              speed: const Duration(milliseconds: 60),
            ),
            TypewriterAnimatedText(
              'Mobile Architect',
              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: isMobile ? 20 : 28,
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w700,
                  ),
              speed: const Duration(milliseconds: 60),
            ),
            TypewriterAnimatedText(
              'Clean Code Advocate',
              textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: isMobile ? 20 : 28,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
              speed: const Duration(milliseconds: 60),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context, bool isMobile) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Text(
        AppConstants.summary,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: isMobile ? 14 : 16,
            ),
      ),
    );
  }

  Widget _buildCTAButtons(bool isMobile) {
    return Wrap(
      spacing: AppDimensions.md,
      runSpacing: AppDimensions.md,
      children: [
        GradientButton(
          label: 'View Projects',
          icon: Icons.folder_open_rounded,
          onTap: widget.onProjectsTap,
        ),
        GradientButton(
          label: 'Contact Me',
          icon: Icons.mail_outline_rounded,
          onTap: widget.onContactTap,
          outlined: true,
        ),
        GradientButton(
          label: 'Download Resume',
          icon: Icons.download_rounded,
          onTap: () => launchUrl(Uri.parse(AppConstants.resumeUrl)),
          outlined: true,
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    final links = [
      _SocialLink(
        icon: FontAwesomeIcons.github,
        url: AppConstants.githubUrl,
        tooltip: 'GitHub',
      ),
      _SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: AppConstants.linkedInUrl,
        tooltip: 'LinkedIn',
      ),
      _SocialLink(
        icon: FontAwesomeIcons.envelope,
        url: AppConstants.emailUrl,
        tooltip: 'Email',
      ),
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: links
          .map((l) => Padding(
                padding: const EdgeInsets.only(right: AppDimensions.md),
                child: _SocialIconButton(link: l),
              ))
          .toList(),
    );
  }
}

class _SocialLink {
  final IconData icon;
  final String url;
  final String tooltip;
  const _SocialLink({required this.icon, required this.url, required this.tooltip});
}

class _SocialIconButton extends StatefulWidget {
  final _SocialLink link;
  const _SocialIconButton({required this.link});

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.link.tooltip,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.link.url)),
          child: AnimatedContainer(
            duration: AppDimensions.animFast,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.glassBg : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              border: Border.all(
                color: _hovered ? AppColors.glassBorder : AppColors.bgBorder,
              ),
            ),
            child: Center(
              child: FaIcon(
                widget.link.icon,
                size: 18,
                color: _hovered ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _anim.value * 6),
        child: child,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Scroll to explore',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.primary, size: 24),
        ],
      ),
    );
  }
}

/// Subtle dot-grid background painter
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.025)
      ..strokeWidth = 1;

    const spacing = 32.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


