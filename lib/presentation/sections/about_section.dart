import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_dimensions.dart';
import '../widgets/common/common_widgets.dart';
import '../widgets/common/section_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.sectionVerticalPadding,
        horizontal: 0,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: ContentWrapper(
        child: AnimatedSection(
          sectionId: 'about',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'About Me',
                subtitle: 'A little about my journey and passion for mobile development.',
              ),
              isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildAvatarCard(context)),
        const SizedBox(width: AppDimensions.xxl),
        Expanded(flex: 3, child: _buildAboutContent(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAvatarCard(context),
        const SizedBox(height: AppDimensions.xl),
        _buildAboutContent(context),
      ],
    );
  }

  Widget _buildAvatarCard(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          // Avatar (Photo)
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.glassBorder, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile_photo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.lg),
          Text(
            AppConstants.fullName,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.xs),
          Text(
            AppConstants.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined,
                  color: AppColors.textSecondary, size: 14),
              const SizedBox(width: 4),
              Text(
                AppConstants.location,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.lg),
          const Divider(color: AppColors.bgBorder),
          const SizedBox(height: AppDimensions.lg),
          // Quick contact items
          _InfoRow(icon: Icons.mail_outline_rounded, text: AppConstants.email),
          const SizedBox(height: AppDimensions.sm),
          _InfoRow(icon: Icons.phone_outlined, text: AppConstants.phone1),
          const SizedBox(height: AppDimensions.lg),
          // Social links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SmallSocialBtn(
                  icon: FontAwesomeIcons.github,
                  url: AppConstants.githubUrl),
              const SizedBox(width: AppDimensions.md),
              _SmallSocialBtn(
                  icon: FontAwesomeIcons.linkedin,
                  url: AppConstants.linkedInUrl),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Story
        Text(
          'My Story',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: AppDimensions.md),
        Text(
          AppConstants.aboutStory,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppDimensions.xl),

        // Stats row
        Wrap(
          spacing: AppDimensions.md,
          runSpacing: AppDimensions.md,
          children: const [
            StatCard(
              value: '4+',
              label: 'Years\nExperience',
              icon: Icons.calendar_today_rounded,
            ),
            StatCard(
              value: '10+',
              label: 'Apps\nShipped',
              icon: Icons.rocket_launch_rounded,
            ),
            StatCard(
              value: '5',
              label: 'Companies\nWorked',
              icon: Icons.business_rounded,
            ),
            StatCard(
              value: '20+',
              label: 'Open Source\nRepos',
              icon: Icons.code_rounded,
            ),
          ],
        ),

        const SizedBox(height: AppDimensions.xl),

        // Education
        GlassCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: const Icon(Icons.school_rounded,
                    color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: AppDimensions.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bachelor\'s in Computer Science',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Higher Technological Institute, Egypt  â€¢  2017 â€“ 2021',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 16),
        const SizedBox(width: AppDimensions.sm),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}

class _SmallSocialBtn extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SmallSocialBtn({required this.icon, required this.url});

  @override
  State<_SmallSocialBtn> createState() => _SmallSocialBtnState();
}

class _SmallSocialBtnState extends State<_SmallSocialBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: AppDimensions.animFast,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.glassBg : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(
                color: _hovered ? AppColors.glassBorder : AppColors.bgBorder),
          ),
          child: FaIcon(widget.icon,
              size: 16,
              color: _hovered ? AppColors.primary : AppColors.textSecondary),
        ),
      ),
    );
  }
}



