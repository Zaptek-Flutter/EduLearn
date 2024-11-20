import 'module.dart';

class Course {
  final String id;
  final String title;
  final String instructor;
  final double rating;
  final double duration; // in hours
  final int modulesCount;
  final String description;
  final String thumbnailUrl; // for course image
  final List<Module> modules;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.rating,
    required this.duration,
    required this.modulesCount,
    required this.description,
    required this.thumbnailUrl,
    required this.modules,
  });
}
