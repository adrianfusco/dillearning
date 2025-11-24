import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/features/learn_language/models/course_with_progress.dart';
import 'package:dillearning/features/learn_language/screens/course_units_screen.dart';
import 'package:dillearning/l10n/app_localizations.dart';

class LanguageLearningScreen extends StatefulWidget {
  const LanguageLearningScreen({super.key});

  @override
  State<LanguageLearningScreen> createState() => _LanguageLearningScreenState();
}

class _LanguageLearningScreenState extends State<LanguageLearningScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<CourseWithProgress>> _coursesWithProgress;
  final ApiService _apiService = ApiService();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _coursesWithProgress = _getCoursesWithProgress();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  Future<List<CourseWithProgress>> _getCoursesWithProgress() async {
    final courses = await _apiService.getAvailableCourses();
    final coursesWithProgress = <CourseWithProgress>[];
    for (final course in courses) {
      final progress = await _apiService.getCourseProgress(course.id);
      coursesWithProgress
          .add(CourseWithProgress(course: course, progress: progress));
    }
    return coursesWithProgress;
  }

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return AppLocalizations.of(context)!.greetingMorning;
    }
    if (hour < 18) {
      return AppLocalizations.of(context)!.greetingAfternoon;
    }
    return AppLocalizations.of(context)!.greetingEvening;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.welcome,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F2027), // dark navy
                  Color(0xFF203A43), // deep teal-blue
                  Color(0xFF2C5364), // cyan-gray accent
                ],
              ),
            ),
            child: FutureBuilder<List<CourseWithProgress>>(
              future: _coursesWithProgress,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoadingState();
                } else if (snapshot.hasError) {
                  return _buildErrorState();
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildNoCoursesState();
                }

                final coursesWithProgress = snapshot.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 100, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGreeting(context),
                      const SizedBox(height: 8),
                      _buildWelcomeMessage(),
                      const SizedBox(height: 24),
                      _buildAppFeatures(),
                      const SizedBox(height: 32),
                      Text(
                        AppLocalizations.of(context)!.availableCourses,
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                                blurRadius: 10,
                                color: Colors.black26,
                                offset: Offset(2, 2)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCourseGrid(coursesWithProgress),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return Text(
      _getGreeting(context),
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildWelcomeMessage() => Text(
        AppLocalizations.of(context)!.withDillearningYouCan,
        style: GoogleFonts.poppins(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [
            Shadow(blurRadius: 10, color: Colors.black26, offset: Offset(2, 2)),
          ],
        ),
      );

  Widget _buildAppFeatures() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildFeatureCard(
            Icons.language,
            AppLocalizations.of(context)!.learnLanguagesTitle,
            AppLocalizations.of(context)!.learnLanguagesDescription,
            Colors.orange,
          ),
          const SizedBox(width: 16),
          _buildFeatureCard(
            Icons.translate,
            AppLocalizations.of(context)!.translateTextTitle,
            AppLocalizations.of(context)!.translateTextDescription,
            Colors.blue,
          ),
          const SizedBox(width: 16),
          _buildFeatureCard(
            Icons.chat_bubble,
            AppLocalizations.of(context)!.chatPracticeTitle,
            AppLocalizations.of(context)!.chatPracticeDescription,
            Colors.green,
          ),
          const SizedBox(width: 16),
          _buildFeatureCard(
            Icons.assistant,
            AppLocalizations.of(context)!.aiAssistantTitle,
            AppLocalizations.of(context)!.aiAssistantDescription,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      IconData icon, String title, String description, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(2, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 36, color: color),
              const Spacer(),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseGrid(List<CourseWithProgress> coursesWithProgress) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth / 220).floor().clamp(1, 4);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.95,
          ),
          itemCount: coursesWithProgress.length,
          itemBuilder: (context, index) {
            final courseWithProgress = coursesWithProgress[index];
            final course = courseWithProgress.course;
            final progress = courseWithProgress.progress;

            return _AnimatedCourseCard(
              courseTitle: course.title,
              courseDescription: course.description,
              fromLanguage: course.fromLanguageCode,
              toLanguage: course.learningLanguageCode,
              progress: progress,
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) =>
                      CourseUnitsScreen(courseId: course.id),
                  transitionsBuilder: (_, anim, __, child) => FadeTransition(
                    opacity: CurvedAnimation(
                        parent: anim, curve: Curves.easeInOutCubic),
                    child: child,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingState() => const Center(
        child: CircularProgressIndicator(color: Colors.tealAccent),
      );

  Widget _buildErrorState() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.red),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.somethingWentWrong,
                style: TextStyle(fontSize: 18, color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() {
                _coursesWithProgress = _getCoursesWithProgress();
              }),
              child: Text(AppLocalizations.of(context)!.retryButton),
            ),
          ],
        ),
      );

  Widget _buildNoCoursesState() =>
      Center(child: Text(AppLocalizations.of(context)!.noCoursesAvailable));
}

class _AnimatedCourseCard extends StatefulWidget {
  final String courseTitle;
  final String courseDescription;
  final String fromLanguage;
  final String toLanguage;
  final double progress;
  final VoidCallback onTap;

  const _AnimatedCourseCard({
    required this.courseTitle,
    required this.courseDescription,
    required this.fromLanguage,
    required this.toLanguage,
    required this.progress,
    required this.onTap,
  });

  @override
  State<_AnimatedCourseCard> createState() => _AnimatedCourseCardState();
}

class _AnimatedCourseCardState extends State<_AnimatedCourseCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.teal.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withValues(alpha: _hovered ? 0.4 : 0.2),
                blurRadius: _hovered ? 16 : 8,
                offset: const Offset(3, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularPercentIndicator(
                  radius: 36.0,
                  lineWidth: 6.0,
                  percent: widget.progress / 100,
                  center: Image.asset(
                    'assets/images/flags/${widget.toLanguage}.png',
                    width: 40,
                  ),
                  progressColor: Colors.teal,
                  backgroundColor: Colors.teal.shade100,
                ),
                Text(
                  widget.courseTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.teal.shade900,
                  ),
                ),
                Text(
                  widget.courseDescription,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.progress.toStringAsFixed(0)}%',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
