import 'package:equatable/equatable.dart';

/// Single bullet point in an experience entry
class ExperienceBullet extends Equatable {
  final String text;
  const ExperienceBullet(this.text);

  @override
  List<Object?> get props => [text];
}

/// Represents a professional work experience entry
class ExperienceEntity extends Equatable {
  final String id;
  final String company;
  final String role;
  final String period;       // e.g. "Aug 2024 – Present"
  final String location;
  final List<String> bullets;
  final bool isCurrent;

  const ExperienceEntity({
    required this.id,
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.bullets,
    this.isCurrent = false,
  });

  @override
  List<Object?> get props => [id, company, role, period];
}
