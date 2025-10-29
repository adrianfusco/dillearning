
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/screens/course_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';

class CourseSelectionScreen extends StatefulWidget {
  const CourseSelectionScreen({super.key});

  @override
  CourseSelectionScreenState createState() => CourseSelectionScreenState();
}

class CourseSelectionScreenState extends State<CourseSelectionScreen> {
  late Future<List<Course>> _courses;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _courses = _apiService.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Course'),
      ),
      body: FutureBuilder<List<Course>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No courses available.'));
          }

          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return ListTile(
                title: Text(course.title),
                subtitle: Text(course.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CourseDetailScreen(courseId: course.id),
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
