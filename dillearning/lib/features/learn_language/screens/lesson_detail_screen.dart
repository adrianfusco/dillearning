
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

  @override
  void initState() {
    super.initState();
    _exercises = _apiService.getExercises(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Details'),
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
          return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ListTile(
                title: Text(exercise.prompt),
                subtitle: Text(exercise.type),
              );
            },
          );
        },
      ),
    );
  }
}
