import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../domain/entities/experience_entity.dart';
import '../widgets/common/common_widgets.dart';
import '../widgets/common/section_widgets.dart';

class ExperienceSection extends StatelessWidget {
  final List<ExperienceEntity> experience;
  const ExperienceSection({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.sectionVerticalPadding),
      color: Theme.of(context).colorScheme.surface,
      child: ContentWrapper(
        child: AnimatedSection(
          sectionId: 'experience',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Experience',
                subtitle:
                    'My professional journey across mobile engineering roles.',
              ),
              ...experience.asMap().entries.map(
                    (entry) => AnimatedSection(
                      sectionId: 'exp-${entry.value.id}',
                      delay: Duration(milliseconds: entry.key * 120),
                      child: _TimelineItem(
                        experience: entry.value,
                        isLast: entry.key == experience.length - 1,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final ExperienceEntity experience;
  final bool isLast;

  const _TimelineItem({required this.experience, required this.isLast});

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _expanded = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return Stack(
      children: [
        // ── Timeline Line ──────────────────────────────────────────────
        if (!widget.isLast)
          Positioned(
            top: 46, // 28 top margin + 14 height + 4 spacing
            bottom: 0,
            left: 29, // 30 (center of 60) - 1 (half of width 2)
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(
                        exp.isCurrent ? 0.6 : 0.3),
                    AppColors.bgBorder,
                  ],
                ),
              ),
            ),
          ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Timeline Dot ──────────────────────────────────────────────
            SizedBox(
              width: 60,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.only(top: 28),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: exp.isCurrent ? AppColors.primary : AppColors.bgBorder,
                    border: Border.all(
                      color: exp.isCurrent
                          ? AppColors.primary
                          : AppColors.textMuted,
                      width: 2,
                    ),
                    boxShadow: exp.isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 2,
                            )
                          ]
                        : null,
                  ),
                ),
              ),
            ),

          // â”€â”€ Content Card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: AppDimensions.xl, top: AppDimensions.md),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: AnimatedContainer(
                    duration: AppDimensions.animNormal,
                    padding: const EdgeInsets.all(AppDimensions.lg),
                    decoration: BoxDecoration(
                      color: _hovered ? (Theme.of(context).brightness == Brightness.dark ? AppColors.bgCardHover : AppColors.lightBgCardHover) : (Theme.of(context).brightness == Brightness.dark ? AppColors.bgCard : AppColors.lightBgCard),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusLg),
                      border: Border.all(
                        color: _hovered
                            ? AppColors.glassBorder
                            : AppColors.bgBorder,
                        width: 1,
                      ),
                      boxShadow: _hovered
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Role & company
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exp.role,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Theme.of(context).brightness == Brightness.dark
                                                ? AppColors.textPrimary
                                                : AppColors.lightTextPrimary,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.business_rounded,
                                        size: 14,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          exp.company,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Period + current badge
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (exp.isCurrent)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.success.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.radiusFull),
                                      border: Border.all(
                                          color: AppColors.success
                                              .withOpacity(0.4)),
                                    ),
                                    child: Text(
                                      'Current',
                                      style: TextStyle(
                                        color: AppColors.success,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  exp.period,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? AppColors.textSecondary
                                              : AppColors.lightTextSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.xs),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 13,
                                color: AppColors.textMuted),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                exp.location,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium,
                              ),
                            ),
                          ],
                        ),

                        // Expandable bullets
                        AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppDimensions.md),
                              const Divider(
                                  color: AppColors.bgBorder, height: 1),
                              const SizedBox(height: AppDimensions.md),
                              ...exp.bullets.map(
                                (bullet) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppDimensions.sm),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(
                                            top: 7, right: 10),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          bullet,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          crossFadeState: _expanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: AppDimensions.animNormal,
                        ),

                        // Tap hint
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () =>
                                setState(() => _expanded = !_expanded),
                            icon: Icon(
                              _expanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            label: Text(
                              _expanded ? 'Less' : 'Details',
                              style: const TextStyle(
                                  color: AppColors.primary, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ],
    );
  }
}




