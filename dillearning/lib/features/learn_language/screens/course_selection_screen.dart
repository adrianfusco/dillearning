
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:dillearning/features/learn_language/screens/unit_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/l10n/app_localizations.dart';

class CourseSelectionScreen extends StatefulWidget {
  const CourseSelectionScreen({super.key});

  @override
  CourseSelectionScreenState createState() => CourseSelectionScreenState();
}

class CourseSelectionScreenState extends State<CourseSelectionScreen> {
  late Future<List<Course>> _courses;
  final ApiService _apiService = ApiService();
  List<bool> _isCourseExpanded = [];

  @override
  void initState() {
    super.initState();
    _courses = _apiService.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectCourseTitle),
      ),
      body: FutureBuilder<List<Course>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(AppLocalizations.of(context)!.errorWithMessage(snapshot.error.toString())));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noCoursesAvailable));
          }

          final courses = snapshot.data!;
          if (_isCourseExpanded.length != courses.length) {
            _isCourseExpanded = List<bool>.filled(courses.length, false);
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
    return Column(
      children: course.units.map((Unit unit) {
        return ListTile(
          title: Text(unit.title),
          subtitle: Text(AppLocalizations.of(context)!.unitOrder(unit.order.toString())),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UnitDetailScreen(unitId: unit.id),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
