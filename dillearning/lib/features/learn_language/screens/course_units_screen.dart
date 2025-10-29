import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/screens/unit_detail_screen.dart';
import 'package:flutter/material.dart';

class CourseUnitsScreen extends StatefulWidget {
  final int courseId;

  const CourseUnitsScreen({super.key, required this.courseId});

  @override
  CourseUnitsScreenState createState() => CourseUnitsScreenState();
}

class CourseUnitsScreenState extends State<CourseUnitsScreen> {
  late Future<Course> _course;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _course = _apiService.getCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Units'),
      ),
      body: FutureBuilder<Course>(
        future: _course,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No course data available.'));
          }

          final course = snapshot.data!;
          return ListView.builder(
            itemCount: course.units.length,
            itemBuilder: (context, index) {
              final unit = course.units[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(unit.title),
                  subtitle: Text('Unit ${unit.order}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UnitDetailScreen(unitId: unit.id),
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
