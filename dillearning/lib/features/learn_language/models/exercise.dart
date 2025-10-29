
import 'dart:convert';

class Exercise {
  final int id;
  final String type;
  final String prompt;
  final String answer;
  final List<String> options;

  Exercise({
    required this.id,
    required this.type,
    required this.prompt,
    required this.answer,
    required this.options,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    List<String> optionsList = [];
    if (json['options'] != null) {
      final decodedOptions = jsonDecode(json['options']);
      if (decodedOptions is List) {
        optionsList = decodedOptions.map((item) => item.toString()).toList();
      }
    }

    return Exercise(
      id: json['id'],
      type: json['type'] ?? 'unknown',
      prompt: json['prompt'] ?? '',
      answer: json['answer'] ?? '',
      options: optionsList,
    );
  }
}
