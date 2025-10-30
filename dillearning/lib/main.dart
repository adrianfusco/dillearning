import 'package:dillearning/core/env_config.dart';
import 'package:dillearning/core/services/language_service.dart';
import 'package:dillearning/core/services/theme_service.dart';
import 'package:dillearning/features/home/home_screen.dart';
import 'package:dillearning/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dillearning/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => LanguageNotifier()),
      ],
      child: const MainApplication(),
    ),
  );
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier, LanguageNotifier>(
      builder: (context, themeNotifier, languageNotifier, child) {
        return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: languageNotifier.locale,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF58CC02),
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF58CC02),
              brightness: Brightness.dark,
            ),
          ),
          themeMode: themeNotifier.themeMode,
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}

