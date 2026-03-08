import 'package:equatable/equatable.dart';

class SkillItem extends Equatable {
  final String name;
  final double proficiency; // 0.0 – 1.0
  const SkillItem({required this.name, required this.proficiency});

  @override
  List<Object?> get props => [name, proficiency];
}

/// Groups skills by category (e.g., Flutter, Android, Firebase, DevOps)
class SkillCategoryEntity extends Equatable {
  final String id;
  final String categoryName;
  final String icon;           // emoji or icon code string
  final List<SkillItem> skills;
  final String accentColor;    // hex string

  const SkillCategoryEntity({
    required this.id,
    required this.categoryName,
    required this.icon,
    required this.skills,
    required this.accentColor,
  });

  @override
  List<Object?> get props => [id, categoryName];
}
