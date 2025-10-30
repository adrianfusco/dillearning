
import 'package:dillearning/features/learn_language/models/unit.dart';

class Course {
  final int id;
  final String code;
  final String title;
  final String description;
  final int fromLanguageId;
  final int learningLanguageId;
  final String fromLanguageCode;
  final String learningLanguageCode;
  final List<Unit> units;

  Course({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.fromLanguageId,
    required this.learningLanguageId,
    required this.fromLanguageCode,
    required this.learningLanguageCode,
    required this.units,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var unitsList = json['units'] as List? ?? [];
    List<Unit> units = unitsList.map((i) => Unit.fromJson(i)).toList();
    String code = json['code'] ?? '';
    List<String> codeParts = code.split('-');
    String fromLanguageCode = codeParts.isNotEmpty ? codeParts[0] : '';
    String learningLanguageCode = codeParts.length > 1 ? codeParts[1] : '';

    return Course(
      id: json['id'],
      code: code,
      title: json['title'] ?? 'Untitled Course',
      description: json['description'] ?? 'No description available',
      fromLanguageId: json['from_language_id'] ?? 0,
      learningLanguageId: json['learning_language_id'] ?? 0,
      fromLanguageCode: fromLanguageCode,
      learningLanguageCode: learningLanguageCode,
      units: units,
    );
  }
}
