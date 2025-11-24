import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Dillearning - Languages Learning'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Dillearning!'**
  String get welcome;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @startLearningLanguage.
  ///
  /// In en, this message translates to:
  /// **'Start Learning Language'**
  String get startLearningLanguage;

  /// No description provided for @chatWithAI.
  ///
  /// In en, this message translates to:
  /// **'Chat with AI for practicing'**
  String get chatWithAI;

  /// No description provided for @translator.
  ///
  /// In en, this message translates to:
  /// **'Translator'**
  String get translator;

  /// No description provided for @translatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Translator'**
  String get translatorTitle;

  /// No description provided for @fromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromLabel;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get toLabel;

  /// No description provided for @textToTranslateLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter text to translate'**
  String get textToTranslateLabel;

  /// No description provided for @sameLanguageError.
  ///
  /// In en, this message translates to:
  /// **'Source and target languages cannot be the same'**
  String get sameLanguageError;

  /// No description provided for @translationError.
  ///
  /// In en, this message translates to:
  /// **'Error translating text'**
  String get translationError;

  /// No description provided for @translationResultLabel.
  ///
  /// In en, this message translates to:
  /// **'Translation:'**
  String get translationResultLabel;

  /// No description provided for @translateButton.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translateButton;

  /// No description provided for @emptyTextFieldError.
  ///
  /// In en, this message translates to:
  /// **'Please enter some text to translate'**
  String get emptyTextFieldError;

  /// No description provided for @dillearningAiIsThinking.
  ///
  /// In en, this message translates to:
  /// **'DilLearning AI is thinking...'**
  String get dillearningAiIsThinking;

  /// No description provided for @chatWithDillearningAiTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with Dillearning AI. You can talk about any topic to practice your learning'**
  String get chatWithDillearningAiTitle;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @noCoursesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No courses available.'**
  String get noCoursesAvailable;

  /// No description provided for @courseDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Course Details'**
  String get courseDetailsTitle;

  /// Error message with a placeholder for the actual error
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(String message);

  /// No description provided for @noCourseDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No course data available.'**
  String get noCourseDataAvailable;

  /// Unit order with a placeholder for the order number
  ///
  /// In en, this message translates to:
  /// **'Unit {order}'**
  String unitOrder(String order);

  /// No description provided for @selectCourseTitle.
  ///
  /// In en, this message translates to:
  /// **'Select a Course'**
  String get selectCourseTitle;

  /// No description provided for @chooseLanguageToLearnTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a language to learn'**
  String get chooseLanguageToLearnTitle;

  /// No description provided for @noLanguagesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No languages available.'**
  String get noLanguagesAvailable;

  /// No description provided for @unitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitsTitle;

  /// No description provided for @noUnitsAvailableForCourse.
  ///
  /// In en, this message translates to:
  /// **'No units available for this course.'**
  String get noUnitsAvailableForCourse;

  /// No description provided for @unitDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unit Details'**
  String get unitDetailsTitle;

  /// No description provided for @noUnitDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No unit data available.'**
  String get noUnitDataAvailable;

  /// No description provided for @generateAiExamplesButton.
  ///
  /// In en, this message translates to:
  /// **'Generate AI Examples'**
  String get generateAiExamplesButton;

  /// No description provided for @generateAiExerciseButton.
  ///
  /// In en, this message translates to:
  /// **'Generate AI Exercise'**
  String get generateAiExerciseButton;

  /// Exercise prompt with a placeholder for the prompt text
  ///
  /// In en, this message translates to:
  /// **'Exercise: {prompt}'**
  String exercisePrompt(String prompt);

  /// No description provided for @noExercisesAvailableForConcept.
  ///
  /// In en, this message translates to:
  /// **'No exercises available for this concept.'**
  String get noExercisesAvailableForConcept;

  /// AI Generated Exercise title with a placeholder for the concept
  ///
  /// In en, this message translates to:
  /// **'AI Generated Exercise for \"{concept}\"'**
  String aiGeneratedExerciseForConcept(String concept);

  /// No description provided for @noExerciseGenerated.
  ///
  /// In en, this message translates to:
  /// **'No exercise generated.'**
  String get noExerciseGenerated;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// AI Examples title with a placeholder for the word
  ///
  /// In en, this message translates to:
  /// **'AI Examples for \"{word}\"'**
  String aiExamplesForWord(String word);

  /// Unsupported exercise type message with a placeholder for the type
  ///
  /// In en, this message translates to:
  /// **'Unsupported exercise type: {type}'**
  String unsupportedExerciseType(String type);

  /// No description provided for @checkAnswerButton.
  ///
  /// In en, this message translates to:
  /// **'Check Answer'**
  String get checkAnswerButton;

  /// No description provided for @checkSentenceButton.
  ///
  /// In en, this message translates to:
  /// **'Check Sentence'**
  String get checkSentenceButton;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registrationSuccessful;

  /// Registration failed message with a placeholder for the error
  ///
  /// In en, this message translates to:
  /// **'Registration failed: {error}'**
  String registrationFailed(String error);

  /// No description provided for @registerInDillearningTitle.
  ///
  /// In en, this message translates to:
  /// **'Register in dillearning'**
  String get registerInDillearningTitle;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// Failed to login message with a placeholder for the error
  ///
  /// In en, this message translates to:
  /// **'Failed to login: {error}'**
  String failedToLogin(String error);

  /// No description provided for @welcomeToDillearningTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to dillearning'**
  String get welcomeToDillearningTitle;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @spanishLanguage.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get spanishLanguage;

  /// No description provided for @noExamplesGenerated.
  ///
  /// In en, this message translates to:
  /// **'No examples generated.'**
  String get noExamplesGenerated;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @learning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get learning;

  /// No description provided for @availableCourses.
  ///
  /// In en, this message translates to:
  /// **'Available Courses'**
  String get availableCourses;

  /// No description provided for @withDillearningYouCan.
  ///
  /// In en, this message translates to:
  /// **'With dillearning you can'**
  String get withDillearningYouCan;

  /// No description provided for @learnLanguagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Languages'**
  String get learnLanguagesTitle;

  /// No description provided for @learnLanguagesDescription.
  ///
  /// In en, this message translates to:
  /// **'Expand your horizons by learning multiple languages.'**
  String get learnLanguagesDescription;

  /// No description provided for @translateTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate Texts'**
  String get translateTextTitle;

  /// No description provided for @translateTextDescription.
  ///
  /// In en, this message translates to:
  /// **'Precise translations with advanced AI.'**
  String get translateTextDescription;

  /// No description provided for @chatPracticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice with a Chat'**
  String get chatPracticeTitle;

  /// No description provided for @chatPracticeDescription.
  ///
  /// In en, this message translates to:
  /// **'Talk to Dillarning and improve your fluency.'**
  String get chatPracticeDescription;

  /// No description provided for @aiAssistantTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistantTitle;

  /// No description provided for @aiAssistantDescription.
  ///
  /// In en, this message translates to:
  /// **'Learn with the help of our intelligent assistant.'**
  String get aiAssistantDescription;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get greetingEvening;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
