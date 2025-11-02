import 'package:dillearning/features/learn_language/models/concept.dart';
import 'package:flutter/material.dart';

class ConceptDetailScreen extends StatelessWidget {
  final Concept concept;

  const ConceptDetailScreen({super.key, required this.concept});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(concept.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              concept.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              concept.explanation,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
