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

  @override
  String get dillearningAiIsThinking => 'DilLearning AI is thinking...';

  @override
  String get chatWithDillearningAiTitle =>
      'Chat with Dillearning AI. You can talk about any topic to practice your learning';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get retryButton => 'Retry';

  @override
  String get noCoursesAvailable => 'No courses available.';

  @override
  String get courseDetailsTitle => 'Course Details';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get noCourseDataAvailable => 'No course data available.';

  @override
  String unitOrder(String order) {
    return 'Unit $order';
  }

  @override
  String get selectCourseTitle => 'Select a Course';

  @override
  String get chooseLanguageToLearnTitle => 'Choose a language to learn';

  @override
  String get noLanguagesAvailable => 'No languages available.';

  @override
  String get unitsTitle => 'Units';

  @override
  String get noUnitsAvailableForCourse => 'No units available for this course.';

  @override
  String get unitDetailsTitle => 'Unit Details';

  @override
  String get noUnitDataAvailable => 'No unit data available.';

  @override
  String get generateAiExamplesButton => 'Generate AI Examples';

  @override
  String get generateAiExerciseButton => 'Generate AI Exercise';

  @override
  String exercisePrompt(String prompt) {
    return 'Exercise: $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'No exercises available for this concept.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return 'AI Generated Exercise for \"$concept\"';
  }

  @override
  String get noExerciseGenerated => 'No exercise generated.';

  @override
  String get closeButton => 'Close';

  @override
  String aiExamplesForWord(String word) {
    return 'AI Examples for \"$word\"';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Unsupported exercise type: $type';
  }

  @override
  String get checkAnswerButton => 'Check Answer';

  @override
  String get checkSentenceButton => 'Check Sentence';

  @override
  String get registrationSuccessful => 'Registration successful';

  @override
  String registrationFailed(String error) {
    return 'Registration failed: $error';
  }

  @override
  String get registerInDillearningTitle => 'Register in dillearning';

  @override
  String get registerButton => 'Register';

  @override
  String failedToLogin(String error) {
    return 'Failed to login: $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Welcome to dillearning';

  @override
  String get loginButton => 'Login';

  @override
  String get englishLanguage => 'English';

  @override
  String get spanishLanguage => 'Español';

  @override
  String get noExamplesGenerated => 'No examples generated.';

  @override
  String get profile => 'Profile';

  @override
  String get learning => 'Learning';

  @override
  String get availableCourses => 'Available Courses';

  @override
  String get withDillearningYouCan => 'With dillearning you can';

  @override
  String get learnLanguagesTitle => 'Learn Languages';

  @override
  String get learnLanguagesDescription =>
      'Expand your horizons by learning multiple languages.';

  @override
  String get translateTextTitle => 'Translate Texts';

  @override
  String get translateTextDescription =>
      'Precise translations with advanced AI.';

  @override
  String get chatPracticeTitle => 'Practice with a Chat';

  @override
  String get chatPracticeDescription =>
      'Talk to Dillarning and improve your fluency.';

  @override
  String get aiAssistantTitle => 'AI Assistant';

  @override
  String get aiAssistantDescription =>
      'Learn with the help of our intelligent assistant.';

  @override
  String get greetingMorning => 'Good Morning';

  @override
  String get greetingAfternoon => 'Good Afternoon';

  @override
  String get greetingEvening => 'Good Evening';
}
