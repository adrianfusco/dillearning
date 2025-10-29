
import 'package:dillearning/features/learn_language/models/exercise.dart';

class Lesson {
  final int id;
  final String title;
  final String description;
  final int order;
  final List<Exercise> exercises;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.exercises,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    var exercisesList = json['exercises'] as List? ?? [];
    List<Exercise> exercises =
        exercisesList.map((i) => Exercise.fromJson(i)).toList();

    return Lesson(
      id: json['id'],
      title: json['title'] ?? 'Untitled Lesson',
      description: json['description'] ?? 'No description',
      order: json['order'] ?? 0,
      exercises: exercises,
    );
  }
}
