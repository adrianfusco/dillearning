
import 'package:dillearning/features/learn_language/models/exercise.dart';

class Concept {
  final int id;
  final String title;
  final String explanation;
  final int unitId;
  final List<Exercise> exercises;

  Concept({
    required this.id,
    required this.title,
    required this.explanation,
    required this.unitId,
    required this.exercises,
  });

  factory Concept.fromJson(Map<String, dynamic> json) {
    var exercisesList = json['exercises'] as List? ?? [];
    List<Exercise> exercises =
        exercisesList.map((i) => Exercise.fromJson(i)).toList();

    return Concept(
      id: json['id'],
      title: json['title'],
      explanation: json['explanation'],
      unitId: json['unit_id'],
      exercises: exercises,
    );
  }
}
