import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../domain/entities/skill_category_entity.dart';
import '../widgets/common/common_widgets.dart';
import '../widgets/common/section_widgets.dart';

class SkillsSection extends StatelessWidget {
  final List<SkillCategoryEntity> categories;
  const SkillsSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.sectionVerticalPadding),
      child: ContentWrapper(
        child: AnimatedSection(
          sectionId: 'skills',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Skills & Technologies',
                subtitle:
                    'My technical expertise organized by domain â€” built over 4+ years of shipping real products.',
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossCount = constraints.maxWidth >= 900
                      ? 2
                      : constraints.maxWidth >= 600
                          ? 2
                          : 1;
                  return Wrap(
                    spacing: AppDimensions.lg,
                    runSpacing: AppDimensions.lg,
                    children: categories.map((cat) {
                      return SizedBox(
                        width: constraints.maxWidth / crossCount -
                            (crossCount > 1 ? AppDimensions.lg / 2 : 0),
                        child: AnimatedSection(
                          sectionId: 'skill-cat-${cat.id}',
                          delay: Duration(
                              milliseconds: categories.indexOf(cat) * 150),
                          child: _SkillCategoryCard(category: cat),
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

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategoryEntity category;
  const _SkillCategoryCard({required this.category});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _hovered = false;

  Color get _accent =>
      _parseColor(widget.category.accentColor) ?? AppColors.primary;

  Color? _parseColor(String hex) {
    try {
      final h = hex.replaceAll('#', '');
      return Color(int.parse('FF$h', radix: 16));
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppDimensions.animNormal,
        padding: const EdgeInsets.all(AppDimensions.xl),
        decoration: BoxDecoration(
          color: _hovered ? (Theme.of(context).brightness == Brightness.dark ? AppColors.bgCardHover : AppColors.lightBgCardHover) : (Theme.of(context).brightness == Brightness.dark ? AppColors.bgCard : AppColors.lightBgCard),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(
            color: _hovered ? _accent.withOpacity(0.4) : AppColors.bgBorder,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: _accent.withOpacity(0.12),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _accent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    border:
                        Border.all(color: _accent.withOpacity(0.3), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      widget.category.icon,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.md),
                Text(
                  widget.category.categoryName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.xl),
            // Skills list
            ...widget.category.skills.map(
              (skill) => Padding(
                padding:
                    const EdgeInsets.only(bottom: AppDimensions.md),
                child: _SkillBar(skill: skill, accentColor: _accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillBar extends StatefulWidget {
  final SkillItem skill;
  final Color accentColor;
  const _SkillBar({required this.skill, required this.accentColor});

  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _widthAnim;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: AppDimensions.animXSlow);
    _widthAnim = Tween<double>(begin: 0, end: widget.skill.proficiency)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _visible = true);
        _ctrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.skill.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: AppDimensions.animNormal,
              child: Text(
                '${(widget.skill.proficiency * 100).toInt()}%',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: widget.accentColor,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.xs),
        LayoutBuilder(
          builder: (ctx, constraints) => Container(
            height: 6,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: AppColors.bgBorder,
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _widthAnim,
              builder: (_, __) => FractionallySizedBox(
                widthFactor: _visible ? _widthAnim.value : 0,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      colors: [
                        widget.accentColor.withOpacity(0.7),
                        widget.accentColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}





