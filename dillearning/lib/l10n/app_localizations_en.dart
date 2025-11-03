// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Languages Learning';

  @override
  String get welcome => 'Welcome to Dillearning!';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get logout => 'Logout';

  @override
  String get startLearningLanguage => 'Start Learning Language';

  @override
  String get chatWithAI => 'Chat with AI for practicing';

  @override
  String get translator => 'Translator';

  @override
  String get translatorTitle => 'Translator';

  @override
  String get fromLabel => 'From';

  @override
  String get toLabel => 'To';

  @override
  String get textToTranslateLabel => 'Enter text to translate';

  @override
  String get sameLanguageError =>
      'Source and target languages cannot be the same';

  @override
  String get translationError => 'Error translating text';

  @override
  String get translationResultLabel => 'Translation:';

  @override
  String get translateButton => 'Translate';

  @override
  String get emptyTextFieldError => 'Please enter some text to translate';
}
