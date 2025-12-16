import 'package:dillearning/core/services/api_service.dart';
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
    final apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                ClipOval(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    child: Text(
                      _userName.isNotEmpty ? _userName[0].toUpperCase() : '',
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _userName,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.brightness_6),
                  title: Text(AppLocalizations.of(context)!.theme),
                  trailing: Switch(
                    value: themeNotifier.themeMode == ThemeMode.dark,
                    onChanged: (bool value) {
                      themeNotifier
                          .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.language),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.selectLanguage),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (var language in [
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .englishLanguage,
                                      'locale': Locale('en')
                                    },
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .spanishLanguage,
                                      'locale': Locale('es')
                                    },
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .italianLanguage,
                                      'locale': Locale('it')
                                    },
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .galicianLanguage,
                                      'locale': Locale('gl')
                                    },
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .portugueseLanguage,
                                      'locale': Locale('pt')
                                    },
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .turkishLanguage,
                                      'locale': Locale('tr')
                                    },
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .russianLanguage,
                                      'locale': Locale('ru')
                                    },
                                    {
                                      'label': AppLocalizations.of(context)!
                                          .frenchLanguage,
                                      'locale': Locale('fr')
                                    }
                                  ])
                                    ListTile(
                                      title: Text(language['label']
                                          as String),
                                      onTap: () {
                                        languageNotifier.setLocale(language[
                                                'locale']
                                            as Locale);
                                        Navigator.of(context)
                                            .pop();
                                      },
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await apiService.logout();
              await SessionService().clearSession();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: Text(AppLocalizations.of(context)!.logout),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 224, 218, 217),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
