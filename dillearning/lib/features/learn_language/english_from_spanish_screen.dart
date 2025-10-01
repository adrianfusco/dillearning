import 'package:dillearning/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class EnglishFromSpanishScreen extends StatelessWidget {
  const EnglishFromSpanishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inglés desde Español'),
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
      body: const Center(child: Text('Aquí aprenderás inglés.')),
    );
  }
}
