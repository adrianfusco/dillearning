import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/screens/course_units_screen.dart';
import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  LanguageSelectionScreenState createState() => LanguageSelectionScreenState();
}

class LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late Future<List<Course>> _courses;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _courses = _apiService.getAvailableCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a language to learn'),
      ),
      body: FutureBuilder<List<Course>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No languages available.'));
          }

          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/flags/${course.fromLanguageCode}.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/images/flags/${course.learningLanguageCode}.png',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  title: Text(course.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CourseUnitsScreen(courseId: course.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
