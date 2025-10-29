
import 'package:dillearning/features/learn_language/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';

class LessonDetailScreen extends StatefulWidget {
  final int lessonId;

  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  LessonDetailScreenState createState() => LessonDetailScreenState();
}

class LessonDetailScreenState extends State<LessonDetailScreen> {
  late Future<List<Exercise>> _exercises;
  final ApiService _apiService = ApiService();
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _exercises = _apiService.getExercises(widget.lessonId);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Details'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: FutureBuilder<List<Exercise>>(
            future: _exercises,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              return LinearProgressIndicator(
                value: (snapshot.data!.isEmpty)
                    ? 0
                    : (_currentPage + 1) / snapshot.data!.length,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              );
            },
          ),
        ),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _exercises,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises available.'));
          }

          final exercises = snapshot.data!;
          return PageView.builder(
            controller: _pageController,
            itemCount: exercises.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return _buildExercise(exercise);
            },
          );
        },
      ),
    );
  }

  Widget _buildExercise(Exercise exercise) {
    switch (exercise.type) {
      case 'multiple_choice':
        return _buildMultipleChoiceExercise(exercise);
      case 'translation':
        return _buildTranslationExercise(exercise);
      default:
        return Center(child: Text('Unsupported exercise type: ${exercise.type}'));
    }
  }

  Widget _buildMultipleChoiceExercise(Exercise exercise) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.prompt,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ...exercise.options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  _checkAnswer(option == exercise.answer);
                },
                child: Text(option),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTranslationExercise(Exercise exercise) {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.prompt,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter your translation',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _checkAnswer(controller.text.trim().toLowerCase() ==
                  exercise.answer.toLowerCase());
            },
            child: const Text('Check Answer'),
          ),
        ],
      ),
    );
  }

  void _checkAnswer(bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Correct!' : 'Incorrect. Try again!'),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );
    if (isCorrect) {
      if (_currentPage < (_pageController.page?.round() ?? 0) + 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }
}
