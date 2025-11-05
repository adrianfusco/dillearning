
import 'package:dillearning/features/learn_language/models/concept.dart';

class Unit {
  final int id;
  final String title;
  final int order;
  final List<Concept> concepts;

  Unit({
    required this.id,
    required this.title,
    required this.order,
    required this.concepts,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    var conceptsList = json['concepts'] as List? ?? [];
    List<Concept> concepts =
        conceptsList.map((i) => Concept.fromJson(i)).toList();

    return Unit(
      id: json['id'],
      title: json['title'] ?? 'Untitled Unit',
      order: json['order'] ?? 0,
      concepts: concepts,
    );
  }
}
