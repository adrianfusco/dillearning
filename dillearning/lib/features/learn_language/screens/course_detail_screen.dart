
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/screens/unit_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/l10n/app_localizations.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  CourseDetailScreenState createState() => CourseDetailScreenState();
}

class CourseDetailScreenState extends State<CourseDetailScreen> {
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
        title: Text(AppLocalizations.of(context)!.courseDetailsTitle),
      ),
      body: FutureBuilder<Course>(
        future: _course,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(AppLocalizations.of(context)!.errorWithMessage(snapshot.error.toString())));
          } else if (!snapshot.hasData) {
            return Center(child: Text(AppLocalizations.of(context)!.noCourseDataAvailable));
          }

          final course = snapshot.data!;
          return ListView.builder(
            itemCount: course.units.length,
            itemBuilder: (context, index) {
              final unit = course.units[index];
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
            },
          );
        },
      ),
    );
  }
}
