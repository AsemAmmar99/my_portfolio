import 'package:equatable/equatable.dart';

/// Represents a professional project
class ProjectEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> techStack;
  final String? githubUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? demoUrl;
  final String category; // 'flutter' | 'android' | 'opensource'
  final bool isFeatured;

  const ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.techStack,
    this.githubUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.demoUrl,
    required this.category,
    this.isFeatured = false,
  });

  @override
  List<Object?> get props => [id, name, description, techStack, category];
}
