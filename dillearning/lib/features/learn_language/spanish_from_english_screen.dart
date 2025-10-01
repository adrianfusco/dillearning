import 'package:dillearning/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class SpanishFromEnglishScreen extends StatelessWidget {
  const SpanishFromEnglishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spanish from English'),
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
      body: const Center(
        child: Text('Here you will learn Spanish.'),
      ),
    );
  }
}
