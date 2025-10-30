import 'package:dillearning/core/services/language_service.dart';
import 'package:dillearning/core/services/session_service.dart';
import 'package:dillearning/core/services/theme_service.dart';
import 'package:dillearning/features/auth/login_screen.dart';
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
    if (session != null) {
      setState(() {
        _userName = session.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    _userName.isNotEmpty ? _userName[0].toUpperCase() : '',
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _userName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.brightness_6),
                  title: const Text('Theme'),
                  trailing: DropdownButton<ThemeMode>(
                    value: themeNotifier.themeMode,
                    onChanged: (ThemeMode? newThemeMode) {
                      if (newThemeMode != null) {
                        themeNotifier.setTheme(newThemeMode);
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System'),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  trailing: DropdownButton<Locale>(
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {
                final navigator = Navigator.of(context);
                await SessionService().clearSession();
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
