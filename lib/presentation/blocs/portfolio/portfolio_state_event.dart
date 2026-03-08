import 'package:equatable/equatable.dart';
import '../../../domain/entities/experience_entity.dart';
import '../../../domain/entities/project_entity.dart';
import '../../../domain/entities/skill_category_entity.dart';

// â”€â”€ Events â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
abstract class PortfolioEvent extends Equatable {
  const PortfolioEvent();
  @override
  List<Object?> get props => [];
}

class LoadPortfolioEvent extends PortfolioEvent {
  const LoadPortfolioEvent();
}

// â”€â”€ States â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
abstract class PortfolioState extends Equatable {
  const PortfolioState();
  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final List<ProjectEntity> projects;
  final List<ExperienceEntity> experience;
  final List<SkillCategoryEntity> skillCategories;

  const PortfolioLoaded({
    required this.projects,
    required this.experience,
    required this.skillCategories,
  });

  @override
  List<Object?> get props => [projects, experience, skillCategories];
}

class PortfolioError extends PortfolioState {
  final String message;
  const PortfolioError(this.message);
  @override
  List<Object?> get props => [message];
}

