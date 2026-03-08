import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../domain/entities/project_entity.dart';
import '../widgets/common/common_widgets.dart';
import '../widgets/common/section_widgets.dart';

class ProjectsSection extends StatefulWidget {
  final List<ProjectEntity> projects;
  const ProjectsSection({super.key, required this.projects});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _filter = 'all';

  List<ProjectEntity> get _filtered {
    if (_filter == 'all') return widget.projects;
    return widget.projects.where((p) => p.category == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.sectionVerticalPadding),
      child: ContentWrapper(
        child: AnimatedSection(
          sectionId: 'projects',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Projects',
                subtitle:
                    'A selection of production-grade and open-source work.',
              ),
              _FilterBar(
                activeFilter: _filter,
                onFilterChanged: (f) => setState(() => _filter = f),
              ),
              const SizedBox(height: AppDimensions.xl),
              LayoutBuilder(
                builder: (ctx, constraints) {
                  final cols = constraints.maxWidth >= 900
                      ? 3
                      : constraints.maxWidth >= 600
                          ? 2
                          : 1;
                  return Wrap(
                    spacing: AppDimensions.lg,
                    runSpacing: AppDimensions.lg,
                    children: _filtered.asMap().entries.map((entry) {
                      final cardWidth = (constraints.maxWidth -
                              (cols - 1) * AppDimensions.lg) /
                          cols;
                      return AnimatedSection(
                        sectionId: 'proj-${entry.value.id}',
                        delay: Duration(milliseconds: entry.key * 80),
                        child: SizedBox(
                          width: cardWidth,
                          child: _ProjectCard(project: entry.value),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final String activeFilter;
  final ValueChanged<String> onFilterChanged;

  const _FilterBar(
      {required this.activeFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    const filters = [
      ('all', 'All Projects'),
      ('flutter', 'Flutter'),
      ('android', 'Android'),
      ('opensource', 'Open Source'),
    ];

    return Wrap(
      spacing: AppDimensions.sm,
      runSpacing: AppDimensions.sm,
      children: filters
          .map(
            (f) => _FilterChip(
              label: f.$2,
              isActive: activeFilter == f.$1,
              onTap: () => onFilterChanged(f.$1),
            ),
          )
          .toList(),
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label, required this.isActive, required this.onTap});

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDimensions.animFast,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: active
                ? AppColors.primary
                : _hovered
                    ? AppColors.glassBg
                    : AppColors.bgCard,
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
            border: Border.all(
              color: active
                  ? AppColors.primary
                  : _hovered
                      ? AppColors.glassBorder
                      : AppColors.bgBorder,
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: active ? Colors.white : AppColors.textSecondary,
              fontSize: 13,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectEntity project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final isFlutter = p.category == 'flutter';

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppDimensions.animNormal,
        transform: Matrix4.identity()
          ..translate(0.0, _hovered ? -6.0 : 0.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: _hovered ? (Theme.of(context).brightness == Brightness.dark ? AppColors.bgCardHover : AppColors.lightBgCardHover) : (Theme.of(context).brightness == Brightness.dark ? AppColors.bgCard : AppColors.lightBgCard),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(
            color: _hovered ? AppColors.glassBorder : AppColors.bgBorder,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // â”€â”€ Card Header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.radiusLg),
                  topRight: Radius.circular(AppDimensions.radiusLg),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isFlutter
                      ? [const Color(0xFF0D2137), const Color(0xFF0077B6)]
                      : [const Color(0xFF0D1A10), const Color(0xFF1A3020)],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isFlutter
                          ? Icons.phone_android_rounded
                          : p.category == 'android'
                              ? Icons.android_rounded
                              : Icons.code_rounded,
                      color: isFlutter
                          ? AppColors.primary
                          : AppColors.success,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    if (p.isFeatured)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusFull),
                          border: Border.all(
                              color: AppColors.warning.withOpacity(0.4)),
                        ),
                        child: Text(
                          'â­ Featured',
                          style: TextStyle(
                            color: AppColors.warning,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // â”€â”€ Card Body â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Padding(
              padding: const EdgeInsets.all(AppDimensions.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  Text(
                    p.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimensions.md),

                  // Tech chips
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: p.techStack
                        .take(4)
                        .map((t) => TechChip(label: t))
                        .toList(),
                  ),
                  const SizedBox(height: AppDimensions.md),

                  // Action buttons
                  Wrap(
                    spacing: AppDimensions.sm,
                    runSpacing: AppDimensions.sm,
                    children: [
                      if (p.githubUrl != null)
                        _CardAction(
                          icon: Icons.code_rounded,
                          label: 'Source',
                          url: p.githubUrl!,
                        ),
                      if (p.playStoreUrl != null)
                        _CardAction(
                          icon: Icons.shop_rounded,
                          label: 'Play Store',
                          url: p.playStoreUrl!,
                          color: AppColors.success,
                        ),
                      if (p.appStoreUrl != null)
                        _CardAction(
                          icon: Icons.apple_rounded,
                          label: 'App Store',
                          url: p.appStoreUrl!,
                          color: AppColors.textSecondary,
                        ),
                      if (p.demoUrl != null)
                        _CardAction(
                          icon: Icons.open_in_new_rounded,
                          label: 'Live Demo',
                          url: p.demoUrl!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardAction extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final Color? color;

  const _CardAction({
    required this.icon,
    required this.label,
    required this.url,
    this.color,
  });

  @override
  State<_CardAction> createState() => _CardActionState();
}

class _CardActionState extends State<_CardAction> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: AppDimensions.animFast,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: _hovered ? color.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(
              color: _hovered ? color.withOpacity(0.4) : AppColors.bgBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 13, color: color),
              const SizedBox(width: 5),
              Text(
                widget.label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




