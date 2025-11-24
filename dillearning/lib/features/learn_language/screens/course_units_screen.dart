import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/features/learn_language/models/unit_with_access.dart';
import 'package:dillearning/features/learn_language/screens/unit_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/l10n/app_localizations.dart';

class CourseUnitsScreen extends StatefulWidget {
  final int courseId;

  const CourseUnitsScreen({super.key, required this.courseId});

  @override
  CourseUnitsScreenState createState() => CourseUnitsScreenState();
}

class CourseUnitsScreenState extends State<CourseUnitsScreen> {
  late Future<List<UnitWithAccess>> _unitsWithAccess;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _unitsWithAccess = _getUnitsWithAccess();
  }

  Future<List<UnitWithAccess>> _getUnitsWithAccess() async {
    final course = await _apiService.getCourse(widget.courseId);
    final units = course.units;
    final unitsWithAccess = <UnitWithAccess>[];

    for (final unit in units) {
      final isAccessible = await _apiService.canAccessUnit(unit.id);
      unitsWithAccess.add(UnitWithAccess(unit: unit, isAccessible: isAccessible));
    }

    return unitsWithAccess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.unitsTitle),
      ),
      body: FutureBuilder<List<UnitWithAccess>>(
        future: _unitsWithAccess,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(AppLocalizations.of(context)!.errorWithMessage(snapshot.error.toString())));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noUnitsAvailableForCourse));
          }

          final unitsWithAccess = snapshot.data!;
          return ListView.builder(
            itemCount: unitsWithAccess.length,
            itemBuilder: (context, index) {
              final unitWithAccess = unitsWithAccess[index];
              final unit = unitWithAccess.unit;
              final isAccessible = unitWithAccess.isAccessible;

              return Card(
                margin: const EdgeInsets.all(8.0),
                color: isAccessible ? Colors.white : Colors.grey[300],
                child: ListTile(
                  leading: Icon(
                    isAccessible ? Icons.lock_open : Icons.lock,
                    color: isAccessible ? Colors.green : Colors.grey,
                  ),
                  title: Text(
                    unit.title,
                    style: TextStyle(
                      color: isAccessible ? Colors.black : Colors.grey[600],
                      decoration: isAccessible ? TextDecoration.none : TextDecoration.lineThrough,
                    ),
                  ),
                  subtitle: Text(AppLocalizations.of(context)!.unitOrder(unit.order.toString())),
                  onTap: isAccessible
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnitDetailScreen(unitId: unit.id),
                            ),
                          ).then((_) {
                            // Always refresh when coming back from a unit detail screen.
                            setState(() {
                              _unitsWithAccess = _getUnitsWithAccess();
                            });
                          });
                        }
                      : null, // Disable tap if not accessible
                ),
              );
            },
          );
        },
      ),
    );
  }
}
