import 'package:dillearning/core/services/language_service.dart';
import 'package:dillearning/core/services/session_service.dart';
import 'package:dillearning/core/services/theme_service.dart';
import 'package:dillearning/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    final session = await SessionService().getSession();
    setState(() {
      _userName = session['userName'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              '${AppLocalizations.of(context)!.welcome}, $_userName',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => themeNotifier.setTheme(ThemeMode.light),
              child: const Text('Light theme'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => themeNotifier.setTheme(ThemeMode.dark),
              child: const Text('Dark theme'),
            ),
            const SizedBox(height: 40),
            DropdownButton<Locale>(
              value: languageNotifier.locale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  languageNotifier.setLocale(newLocale);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('es'),
                  child: Text('Español'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
