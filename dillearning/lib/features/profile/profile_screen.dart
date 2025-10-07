import 'package:dillearning/core/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => themeNotifier.setTheme(ThemeMode.light),
              child: const Text('Light theme'),
            ),
            ElevatedButton(
              onPressed: () => themeNotifier.setTheme(ThemeMode.dark),
              child: const Text('Dark theme'),
            ),
          ],
        ),
      ),
    );
  }
}
