import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../blocs/navigation/navigation_bloc.dart';
import '../../blocs/portfolio/portfolio_bloc.dart';
import '../../blocs/portfolio/portfolio_state_event.dart';
import '../../sections/about_section.dart';
import '../../sections/contact_section.dart';
import '../../sections/experience_section.dart';
import '../../sections/hero_section.dart';
import '../../sections/projects_section.dart';
import '../../sections/skills_section.dart';
import '../../widgets/nav/portfolio_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // One GlobalKey per section for scroll-to navigation
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    context.read<PortfolioBloc>().add(const LoadPortfolioEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final navBloc = context.read<NavigationBloc>();

    // Update scrolled state for nav bar appearance
    navBloc.add(UpdateScrolledEvent(_scrollController.offset > 60));

    // Determine active section based on scroll position
    for (var i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 120) {
        navBloc.add(UpdateActiveSectionEvent(i));
        break;
      }
    }
  }

  void _scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // â”€â”€ Scrollable Content â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SingleChildScrollView(
            controller: _scrollController,
            child: BlocBuilder<PortfolioBloc, PortfolioState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // â”€â”€ 0: Hero â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    KeyedSubtree(
                      key: _sectionKeys[0],
                      child: HeroSection(
                        onContactTap: () => _scrollToSection(5),
                        onProjectsTap: () => _scrollToSection(4),
                      ),
                    ),

                    // â”€â”€ 1: About â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    KeyedSubtree(
                      key: _sectionKeys[1],
                      child: const AboutSection(),
                    ),

                    // â”€â”€ 2: Skills â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    KeyedSubtree(
                      key: _sectionKeys[2],
                      child: state is PortfolioLoaded
                          ? SkillsSection(
                              categories: state.skillCategories)
                          : const _SectionPlaceholder(),
                    ),

                    // â”€â”€ 3: Experience â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    KeyedSubtree(
                      key: _sectionKeys[3],
                      child: state is PortfolioLoaded
                          ? ExperienceSection(
                              experience: state.experience)
                          : const _SectionPlaceholder(
                              color: AppColors.bgSecondary),
                    ),

                    // â”€â”€ 4: Projects â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    KeyedSubtree(
                      key: _sectionKeys[4],
                      child: state is PortfolioLoaded
                          ? ProjectsSection(projects: state.projects)
                          : const _SectionPlaceholder(),
                    ),

                    // â”€â”€ 5: Contact â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    KeyedSubtree(
                      key: _sectionKeys[5],
                      child: const ContactSection(),
                    ),

                    // â”€â”€ Footer â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                    const _Footer(),
                  ],
                );
              },
            ),
          ),

          // â”€â”€ Sticky Navigation Bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              sectionKeys: _sectionKeys,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}

/// Loading placeholder shown while PortfolioBloc loads data
class _SectionPlaceholder extends StatelessWidget {
  final Color color;
  const _SectionPlaceholder({this.color = AppColors.bgPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: color,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

/// Footer widget
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.bgBorder, width: 1)),
      ),
      child: Column(
        children: [
          // Social row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterSocial(
                icon: FontAwesomeIcons.github,
                url: AppConstants.githubUrl,
              ),
              const SizedBox(width: 16),
              _FooterSocial(
                icon: FontAwesomeIcons.linkedin,
                url: AppConstants.linkedInUrl,
              ),
              const SizedBox(width: 16),
              _FooterSocial(
                icon: FontAwesomeIcons.envelope,
                url: AppConstants.emailUrl,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Designed & Built by ${AppConstants.fullName}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 6),
          Text(
            'Â© ${DateTime.now().year} Â· Built with Flutter ðŸ’™',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _FooterSocial extends StatefulWidget {
  final IconData icon;
  final String url;
  const _FooterSocial({required this.icon, required this.url});

  @override
  State<_FooterSocial> createState() => _FooterSocialState();
}

class _FooterSocialState extends State<_FooterSocial> {
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
              color: _hovered ? AppColors.glassBorder : Colors.transparent,
            ),
          ),
          child: FaIcon(
            widget.icon,
            size: 16,
            color: _hovered ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

