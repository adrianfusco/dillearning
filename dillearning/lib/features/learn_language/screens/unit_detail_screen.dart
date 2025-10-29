
import 'package:dillearning/features/learn_language/models/lesson.dart';
import 'package:dillearning/features/learn_language/screens/lesson_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';

class UnitDetailScreen extends StatefulWidget {
  final int unitId;

  const UnitDetailScreen({super.key, required this.unitId});

  @override
  UnitDetailScreenState createState() => UnitDetailScreenState();
}

class UnitDetailScreenState extends State<UnitDetailScreen> {
  late Future<List<Lesson>> _lessons;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _lessons = _apiService.getLessons(widget.unitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Details'),
      ),
      body: FutureBuilder<List<Lesson>>(
        future: _lessons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lessons available.'));
          }

          final lessons = snapshot.data!;
          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              return ListTile(
                title: Text(lesson.title),
                subtitle: Text(lesson.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LessonDetailScreen(lessonId: lesson.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
