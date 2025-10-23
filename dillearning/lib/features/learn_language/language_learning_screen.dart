import 'package:flutter/material.dart';
import 'package:dillearning/features/profile/profile_screen.dart';
import 'package:dillearning/core/services/api_service.dart';

class LanguageLearningScreen extends StatelessWidget {
  const LanguageLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn a Language'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: const LanguageSelectionBody(),
    );
  }
}

class LanguageSelectionBody extends StatefulWidget {
  const LanguageSelectionBody({super.key});

  @override
  LanguageSelectionBodyState createState() => LanguageSelectionBodyState();
}

class LanguageSelectionBodyState extends State<LanguageSelectionBody> {
  late Future<List<Map<String, dynamic>>> _languages;
  String selectedLanguageCode = '';
  
  @override
  void initState() {
    super.initState();
    _languages = ApiService.fetchAvailableLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _languages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No languages available.'));
        }

        final languages = snapshot.data!;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                isSelected: List.generate(languages.length, (index) {
                  return languages[index]['code'] == selectedLanguageCode;
                }),
                onPressed: (index) {
                  setState(() {
                    selectedLanguageCode = languages[index]['code']!;
                  });
                },
                children: languages.map((language) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(language['name'] ?? 'Unknown'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageLearningDetailScreen(
                          languageCode: selectedLanguageCode,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Start Learning $selectedLanguageCode'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LanguageLearningDetailScreen extends StatelessWidget {
  final String languageCode;

  const LanguageLearningDetailScreen({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn $languageCode'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Here you will learn $languageCode',
        ),
      ),
    );
  }
}
