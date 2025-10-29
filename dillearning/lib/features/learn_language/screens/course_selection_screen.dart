
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/models/lesson.dart';
import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:dillearning/features/learn_language/screens/lesson_detail_screen.dart';
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
  List<bool> _isCourseExpanded = [];
  final Map<int, List<bool>> _isUnitExpanded = {};

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
          if (_isCourseExpanded.length != courses.length) {
            _isCourseExpanded = List<bool>.filled(courses.length, false);
            for (var course in courses) {
              _isUnitExpanded[course.id] =
                  List<bool>.filled(course.units.length, false);
            }
          }

          return SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _isCourseExpanded[index] = isExpanded;
                });
              },
              children: courses.map<ExpansionPanel>((Course course) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(course.title),
                      subtitle: Text(course.description),
                    );
                  },
                  body: _buildUnits(course),
                  isExpanded: _isCourseExpanded[courses.indexOf(course)],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUnits(Course course) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isUnitExpanded[course.id]![index] = isExpanded;
        });
      },
      children: course.units.map<ExpansionPanel>((Unit unit) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(unit.title),
              subtitle: Text('Unit ${unit.order}'),
            );
          },
          body: _buildLessons(unit),
          isExpanded: _isUnitExpanded[course.id]![course.units.indexOf(unit)],
        );
      }).toList(),
    );
  }

  Widget _buildLessons(Unit unit) {
    return Column(
      children: unit.lessons.map((Lesson lesson) {
        return ListTile(
          title: Text(lesson.title),
          subtitle: Text(lesson.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonDetailScreen(lessonId: lesson.id),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
