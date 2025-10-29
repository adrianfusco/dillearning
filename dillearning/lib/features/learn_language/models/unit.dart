
import 'package:dillearning/features/learn_language/models/lesson.dart';

class Unit {
  final int id;
  final String title;
  final int order;
  final List<Lesson> lessons;

  Unit({
    required this.id,
    required this.title,
    required this.order,
    required this.lessons,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    var lessonsList = json['lessons'] as List? ?? [];
    List<Lesson> lessons = lessonsList.map((i) => Lesson.fromJson(i)).toList();

    return Unit(
      id: json['id'],
      title: json['title'] ?? 'Untitled Unit',
      order: json['order'] ?? 0,
      lessons: lessons,
    );
  }
}
