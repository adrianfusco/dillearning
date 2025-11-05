
import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/features/learn_language/models/exercise.dart';

class UnitDetailScreen extends StatefulWidget {
  final int unitId;

  const UnitDetailScreen({super.key, required this.unitId});

  @override
  UnitDetailScreenState createState() => UnitDetailScreenState();
}

class UnitDetailScreenState extends State<UnitDetailScreen> {
  late Future<Unit> _unit;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _unit = _apiService.getUnit(widget.unitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Details'),
      ),
      body: FutureBuilder<Unit>(
        future: _unit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No unit data available.'));
          }

          final unit = snapshot.data!;
          return ListView.builder(
            itemCount: unit.concepts.length,
            itemBuilder: (context, index) {
              final concept = unit.concepts[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  leading: const Icon(Icons.lightbulb_outline),
                  title: Text(concept.title),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(concept.explanation),
                    ),
                    if (concept.exercises.isNotEmpty)
                      ...concept.exercises.map((exercise) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _showExerciseDialog(exercise);
                            },
                            child: Text('Exercise: ${exercise.prompt}'),
                          ),
                        );
                      })
                    else
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child:
                            Text('No exercises available for this concept.'),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showExerciseDialog(Exercise exercise) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ExerciseDialog(exercise: exercise);
      },
    );
  }
}

class ExerciseDialog extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDialog({super.key, required this.exercise});

  @override
  ExerciseDialogState createState() => ExerciseDialogState();
}

class ExerciseDialogState extends State<ExerciseDialog> {
  String? _feedback;
  Color? _feedbackColor;
  bool _answered = false;
  String? _selectedOption;

  void _checkAnswer(bool isCorrect) {
    if (_answered) return;

    setState(() {
      _answered = true;
      if (isCorrect) {
        _feedback = 'Correct!';
        _feedbackColor = Colors.green;
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });
      } else {
        _feedback = 'Incorrect. Try again!';
        _feedbackColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.exercise.prompt),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildExercise(widget.exercise),
            if (_feedback != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _feedback!,
                  style: TextStyle(
                    color: _feedbackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildExercise(Exercise exercise) {
    switch (exercise.type) {
      case 'multiple_choice':
        return _buildMultipleChoiceExercise(exercise);
      case 'translation':
        return _buildTranslationExercise(exercise);
      default:
        return Center(
            child: Text('Unsupported exercise type: ${exercise.type}'));
    }
  }

  Widget _buildMultipleChoiceExercise(Exercise exercise) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: exercise.options.map((option) {
        Color? buttonColor;
        if (_answered) {
          if (option == exercise.answer) {
            buttonColor = Colors.green;
          } else if (option == _selectedOption) {
            buttonColor = Colors.red;
          }
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: _answered
                ? null
                : () {
                    setState(() {
                      _selectedOption = option;
                    });
                    _checkAnswer(option == exercise.answer);
                  },
            child: Text(option),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTranslationExercise(Exercise exercise) {
    final TextEditingController controller = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          enabled: !_answered,
          decoration: const InputDecoration(
            hintText: 'Enter your translation',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _answered
              ? null
              : () {
                  _checkAnswer(controller.text.trim().toLowerCase() ==
                      exercise.answer.toLowerCase());
                },
          child: const Text('Check Answer'),
        ),
      ],
    );
  }
}
