// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Aprendizaje de Idiomas';

  @override
  String get welcome => '¡Bienvenido a Dillearning!';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Selecciona un idioma';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get startLearningLanguage => 'Empezar a aprender un idioma';

  @override
  String get chatWithAI => 'Habla con la IA para practicar';

  @override
  String get translator => 'Traductor';

  @override
  String get translatorTitle => 'Traductor';

  @override
  String get fromLabel => 'De';

  @override
  String get toLabel => 'A';

  @override
  String get textToTranslateLabel => 'Introduce el texto que quieres traducir';

  @override
  String get sameLanguageError =>
      'El idioma origen y destino no pueden ser iguales';

  @override
  String get translationError => 'Error traduciendo texto';

  @override
  String get translationResultLabel => 'Traducción:';

  @override
  String get translateButton => 'Traducir';

  @override
  String get emptyTextFieldError => 'Por favor, introduce texto para traducir';
}
