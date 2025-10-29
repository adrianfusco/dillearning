
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
    if (json['options'] != null && json['options'] is List) {
      optionsList = List<String>.from(json['options']);
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
