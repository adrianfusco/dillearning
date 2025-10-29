
import 'package:dillearning/features/learn_language/models/unit.dart';

class Course {
  final int id;
  final String title;
  final String description;
  final List<Unit> units;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.units,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var unitsList = json['units'] as List? ?? [];
    List<Unit> units = unitsList.map((i) => Unit.fromJson(i)).toList();

    return Course(
      id: json['id'],
      title: json['title'] ?? 'Untitled Course',
      description: json['description'] ?? 'No description available',
      units: units,
    );
  }
}
