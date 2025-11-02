
import 'package:dillearning/features/learn_language/models/concept.dart';

class Lesson {
  final int id;
  final String title;
  final String description;
  final int order;
  final List<Concept> concepts;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    required this.concepts,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    var conceptsList = json['concepts'] as List? ?? [];
    List<Concept> concepts =
        conceptsList.map((i) => Concept.fromJson(i)).toList();

    return Lesson(
      id: json['id'],
      title: json['title'] ?? 'Untitled Lesson',
      description: json['description'] ?? 'No description',
      order: json['order'] ?? 0,
      concepts: concepts,
    );
  }
}
