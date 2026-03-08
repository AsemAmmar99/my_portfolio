import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_category_entity.dart';

abstract class PortfolioRepository {
  Future<List<ProjectEntity>> getProjects();
  Future<List<ExperienceEntity>> getExperience();
  Future<List<SkillCategoryEntity>> getSkillCategories();
}
