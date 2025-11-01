import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/screens/course_units_screen.dart';

class LanguageLearningScreen extends StatefulWidget {
  const LanguageLearningScreen({super.key});

  @override
  State<LanguageLearningScreen> createState() => _LanguageLearningScreenState();
}

class _LanguageLearningScreenState extends State<LanguageLearningScreen> {
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
        title: const Text('Welcome to dillearning!'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Course>>(
            future: _courses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingState();
              } else if (snapshot.hasError) {
                return _buildErrorState();
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return _buildNoCoursesState();
              }

              final courses = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeMessage(),
                  const SizedBox(height: 24),
                  _buildAppFeatures(),
                  const SizedBox(height: 24),
                  Text(
                    'Cursos disponibles',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildCourseGrid(courses),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Con dillearning puedes:',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildAppFeatures() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFeatureCard(
            Icons.language,
            'Aprende Idiomas',
            'Expande tus horizontes aprendiendo y practicando varios idiomas a tu propio ritmo.',
            Colors.orange,
          ),
          const SizedBox(width: 16),
          _buildFeatureCard(
            Icons.translate,
            'Traduce Textos',
            'Utiliza IA avanzada para traducir textos de diferentes idiomas de manera precisa y rápida.',
            Colors.blue,
          ),
          const SizedBox(width: 16),
          _buildFeatureCard(
            Icons.chat_bubble,
            'Práctica con un Chat',
            'Habla con Dillarning, un chat inteligente que corrige tus errores y te ayuda a mejorar en tiempo real.',
            Colors.green,
          ),
          const SizedBox(width: 16),
          _buildFeatureCard(
            Icons.assistant,
            'Asistente de aprendizaje',
            'Mejora tus conocimientos haciendo uso del asistente IA que te resolverá dudas en todo momento.',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      IconData icon, String title, String description, Color color) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withAlpha((255 * 0.3).round())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text('We are getting your courses ready...',
              style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          const Text('Something went wrong. Please try again.',
              style: TextStyle(fontSize: 18, color: Colors.red)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _courses = _apiService.getAvailableCourses();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoCoursesState() {
    return const Center(child: Text('No courses available.'));
  }

  Widget _buildCourseGrid(List<Course> courses) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth / 200).floor().clamp(1, 4);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.9,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CourseUnitsScreen(courseId: course.id),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade50, Colors.teal.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/flags/${course.fromLanguageCode}.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 18),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/images/flags/${course.learningLanguageCode}.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          course.title,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal.shade900,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          course.description,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.teal.shade700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
