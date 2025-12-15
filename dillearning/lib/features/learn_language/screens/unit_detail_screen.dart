import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/features/learn_language/models/exercise.dart';
import 'dart:convert';
import 'package:reorderables/reorderables.dart';
import 'package:dillearning/l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class UnitDetailScreen extends StatefulWidget {
  final int unitId;

  const UnitDetailScreen({super.key, required this.unitId});

  @override
  UnitDetailScreenState createState() => UnitDetailScreenState();
}

class UnitDetailScreenState extends State<UnitDetailScreen> {
  late Future<Unit> _unitFuture;
  Set<int> _completedExerciseIds = {};
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadUnitData();
  }

  Future<void> _loadUnitData() async {
    setState(() {
      _unitFuture = _apiService.getUnit(widget.unitId);
    });
    try {
      final completedIds = await _apiService.getUnitProgress(widget.unitId);
      setState(() {
        _completedExerciseIds = completedIds.toSet();
      });
    } catch (e) {
      // Handle or log error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.unitDetailsTitle),
      ),
      body: FutureBuilder<Unit>(
        future: _unitFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(AppLocalizations.of(context)!
                    .errorWithMessage(snapshot.error.toString())));
          } else if (!snapshot.hasData) {
            return Center(
                child: Text(AppLocalizations.of(context)!.noUnitDataAvailable));
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
                      child: MarkdownBody(data: concept.explanation),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () => _showAIExamplesDialog(concept.title),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome),
                            const SizedBox(width: 8),
                            Text(AppLocalizations.of(context)!
                                .generateAiExamplesButton),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () =>
                            _showAIGeneratedExerciseDialog(concept.title),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.psychology),
                            const SizedBox(width: 8),
                            Text(AppLocalizations.of(context)!
                                .generateAiExerciseButton),
                          ],
                        ),
                      ),
                    ),
                    if (concept.exercises.isNotEmpty)
                      ...concept.exercises.map((exercise) {
                        final isCompleted =
                            _completedExerciseIds.contains(exercise.id);
                        return Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: ElevatedButton(
                            key: UniqueKey(),
                            onPressed: () => _showExerciseDialog(exercise),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .exercisePrompt(exercise.prompt)),
                                if (isCompleted)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.check_circle,
                                        color: Colors.green),
                                  ),
                              ],
                            ),
                          ),
                        );
                      })
                    else
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(AppLocalizations.of(context)!
                            .noExercisesAvailableForConcept),
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
    ).then((_) => _loadUnitData());
  }

  void _showAIExamplesDialog(String word) {
    showDialog(
      context: context,
      builder: (context) => AIExamplesDialog(word: word),
    );
  }

  void _showAIGeneratedExerciseDialog(String concept) {
    showDialog(
      context: context,
      builder: (context) => AIGeneratedExerciseDialog(concept: concept),
    );
  }
}

class AIGeneratedExerciseDialog extends StatefulWidget {
  final String concept;

  const AIGeneratedExerciseDialog({super.key, required this.concept});

  @override
  State<AIGeneratedExerciseDialog> createState() =>
      _AIGeneratedExerciseDialogState();
}

class _AIGeneratedExerciseDialogState extends State<AIGeneratedExerciseDialog> {
  final ApiService _apiService = ApiService();
  String _exerciseData = '';
  bool _loading = true;
  String _error = '';
  Exercise? _exercise;

  @override
  void initState() {
    super.initState();
    _loadExercise();
  }

  Future<void> _loadExercise() async {
    try {
      await for (var chunk in _apiService.streamExercise(widget.concept)) {
        setState(() => _exerciseData += chunk);
      }
      _exerciseData =
          _exerciseData.replaceAll('```json', '').replaceAll('```', '').trim();
      final exerciseJson = jsonDecode(_exerciseData);
      setState(() {
        _exercise = Exercise.fromJson(exerciseJson);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load or parse exercise: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!
          .aiGeneratedExerciseForConcept(widget.concept)),
      content: SizedBox(
        width: double.maxFinite,
        child: _loading
            ? const SizedBox(
                height: 80, child: Center(child: CircularProgressIndicator()))
            : _error.isNotEmpty
                ? Text(AppLocalizations.of(context)!.errorWithMessage(_error))
                : _exercise != null
                    ? ExerciseView(
                        exercise: _exercise!,
                        isAiGenerated: true,
                      )
                    : Text(
                        AppLocalizations.of(context)!.noExerciseGenerated),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.closeButton),
        ),
      ],
    );
  }
}

class AIExamplesDialog extends StatefulWidget {
  final String word;

  const AIExamplesDialog({super.key, required this.word});

  @override
  State<AIExamplesDialog> createState() => _AIExamplesDialogState();
}

class _AIExamplesDialogState extends State<AIExamplesDialog> {
  final ApiService _apiService = ApiService();
  String _examples = '';
  bool _loading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadExamples();
  }

  Future<void> _loadExamples() async {
    try {
      await for (var chunk in _apiService.streamExamples(widget.word, 'es')) {
        setState(() => _examples += chunk);
      }
      setState(() => _loading = false);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(AppLocalizations.of(context)!.aiExamplesForWord(widget.word)),
      content: SizedBox(
        width: double.maxFinite,
        child: _loading
            ? const SizedBox(
                height: 80, child: Center(child: CircularProgressIndicator()))
            : _error.isNotEmpty
                ? Text(AppLocalizations.of(context)!.errorWithMessage(_error))
                : SingleChildScrollView(
                    child: _examples.trim().isEmpty
                        ? Text(AppLocalizations.of(context)!.noExamplesGenerated)
                        : MarkdownBody(
                            data: _examples,
                            styleSheet: MarkdownStyleSheet(
                              p: const TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ),
                  )
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.closeButton),
        ),
      ],
    );
  }
}

class ExerciseDialog extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDialog({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(exercise.prompt),
      content: SingleChildScrollView(
        child: ExerciseView(exercise: exercise),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(AppLocalizations.of(context)!.closeButton),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ExerciseView extends StatefulWidget {
  final Exercise exercise;
  final bool isAiGenerated;

  const ExerciseView(
      {super.key, required this.exercise, this.isAiGenerated = false});

  @override
  ExerciseViewState createState() => ExerciseViewState();
}

class ExerciseViewState extends State<ExerciseView> {
  final ApiService _apiService = ApiService();
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
        if (!widget.isAiGenerated) {
          _apiService.completeExercise(widget.exercise.id).then((_) {
            Future.delayed(const Duration(milliseconds: 1200), () {
              if (mounted) Navigator.of(context).pop();
            });
          });
        }
      } else {
        _feedback = 'Incorrect. Try again!';
        _feedbackColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.exercise.prompt,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
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
    );
  }

  Widget _buildExercise(Exercise exercise) {
    switch (exercise.type) {
      case 'multiple_choice':
        return _buildMultipleChoiceExercise(exercise);
      case 'translation':
        return _buildTranslationExercise(exercise);
      case 'fill_in_blank':
        return _buildFillInBlankExercise(exercise);
      case 'sentence_order':
        return _buildSentenceOrderExercise(exercise);
      default:
        return Center(
            child: Text(AppLocalizations.of(context)!
                .unsupportedExerciseType(exercise.type)));
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
                    setState(() => _selectedOption = option);
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
                  _checkAnswer(
                    controller.text.trim().toLowerCase() ==
                        exercise.answer.toLowerCase(),
                  );
                },
          child: Text(AppLocalizations.of(context)!.checkAnswerButton),
        ),
      ],
    );
  }

  Widget _buildFillInBlankExercise(Exercise exercise) {
    final TextEditingController controller = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(exercise.prompt),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: !_answered,
          decoration: const InputDecoration(
            hintText: 'Type the missing word',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _answered
              ? null
              : () {
                  _checkAnswer(
                    controller.text.trim().toLowerCase() ==
                        exercise.answer.toLowerCase(),
                  );
                },
          child: Text(AppLocalizations.of(context)!.checkAnswerButton),
        ),
      ],
    );
  }

  Widget _buildSentenceOrderExercise(Exercise exercise) {
    final List<String> words = List<String>.from(exercise.options)..shuffle();

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              exercise.prompt,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            ReorderableWrap(
              spacing: 8,
              runSpacing: 8,
              needsLongPressDraggable: false,
              onReorder: (oldIndex, newIndex) {
                setLocalState(() {
                  final word = words.removeAt(oldIndex);
                  words.insert(newIndex, word);
                });
              },
              children: words.map((word) {
                return Chip(
                  key: ValueKey(word),
                  label: Text(word),
                  backgroundColor: Colors.blue.shade100,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _answered
                  ? null
                  : () {
                      final userSentence = words.join(' ').trim();
                      _checkAnswer(userSentence == exercise.answer);
                    },
              child: Text(AppLocalizations.of(context)!.checkSentenceButton),
            ),
          ],
        );
      },
    );
  }
}

