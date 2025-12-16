// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Изучение языков';

  @override
  String get welcome => 'Добро пожаловать в Dillearning!';

  @override
  String get theme => 'Тема';

  @override
  String get language => 'Язык';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get logout => 'Выйти';

  @override
  String get startLearningLanguage => 'Начать изучать язык';

  @override
  String get chatWithAI => 'Чат с ИИ для практики';

  @override
  String get translator => 'Переводчик';

  @override
  String get translatorTitle => 'Переводчик';

  @override
  String get fromLabel => 'Из';

  @override
  String get toLabel => 'В';

  @override
  String get textToTranslateLabel => 'Введите текст для перевода';

  @override
  String get sameLanguageError =>
      'Языки исходный и целевой не могут быть одинаковыми';

  @override
  String get translationError => 'Ошибка при переводе текста';

  @override
  String get translationResultLabel => 'Перевод:';

  @override
  String get translateButton => 'Перевести';

  @override
  String get emptyTextFieldError => 'Пожалуйста, введите текст для перевода';

  @override
  String get dillearningAiIsThinking => 'ИИ Dillearning обрабатывает...';

  @override
  String get chatWithDillearningAiTitle =>
      'Чат с ИИ Dillearning. Вы можете говорить на любую тему для практики.';

  @override
  String get somethingWentWrong =>
      'Что-то пошло не так. Пожалуйста, попробуйте снова.';

  @override
  String get retryButton => 'Попробовать снова';

  @override
  String get noCoursesAvailable => 'Нет доступных курсов.';

  @override
  String get courseDetailsTitle => 'Детали курса';

  @override
  String errorWithMessage(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get noCourseDataAvailable => 'Нет данных о курсе.';

  @override
  String unitOrder(String order) {
    return 'Единица $order';
  }

  @override
  String get selectCourseTitle => 'Выберите курс';

  @override
  String get chooseLanguageToLearnTitle => 'Выберите язык для изучения';

  @override
  String get noLanguagesAvailable => 'Нет доступных языков.';

  @override
  String get unitsTitle => 'Единицы';

  @override
  String get noUnitsAvailableForCourse =>
      'Для этого курса нет доступных единиц.';

  @override
  String get unitDetailsTitle => 'Детали единицы';

  @override
  String get noUnitDataAvailable => 'Нет данных о единице.';

  @override
  String get generateAiExamplesButton => 'Создать примеры ИИ';

  @override
  String get generateAiExerciseButton => 'Создать упражнение ИИ';

  @override
  String exercisePrompt(String prompt) {
    return 'Упражнение: $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'Нет упражнений для этой концепции.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return 'Упражнение, созданное ИИ для \"$concept\"';
  }

  @override
  String get noExerciseGenerated => 'Упражнение не создано.';

  @override
  String get closeButton => 'Закрыть';

  @override
  String aiExamplesForWord(String word) {
    return 'Примеры ИИ для \"$word\"';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Неподдерживаемый тип упражнения: $type';
  }

  @override
  String get checkAnswerButton => 'Проверить ответ';

  @override
  String get checkSentenceButton => 'Проверить предложение';

  @override
  String get registrationSuccessful => 'Регистрация успешна';

  @override
  String registrationFailed(String error) {
    return 'Не удалось зарегистрироваться: $error';
  }

  @override
  String get registerInDillearningTitle => 'Зарегистрироваться в Dillearning';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String failedToLogin(String error) {
    return 'Не удалось войти: $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Добро пожаловать в Dillearning';

  @override
  String get loginButton => 'Войти';

  @override
  String get englishLanguage => 'English';

  @override
  String get spanishLanguage => 'Español';

  @override
  String get noExamplesGenerated => 'Примеры не сгенерированы.';

  @override
  String get profile => 'Профиль';

  @override
  String get learning => 'Обучение';

  @override
  String get availableCourses => 'Доступные курсы';

  @override
  String get withDillearningYouCan => 'С Dillearning вы можете';

  @override
  String get learnLanguagesTitle => 'Изучать языки';

  @override
  String get learnLanguagesDescription =>
      'Расширьте свои горизонты, изучая несколько языков.';

  @override
  String get translateTextTitle => 'Переводить тексты';

  @override
  String get translateTextDescription =>
      'Точные переводы с использованием продвинутого ИИ.';

  @override
  String get chatPracticeTitle => 'Практика через чат';

  @override
  String get chatPracticeDescription =>
      'Говорите с Dillearning и улучшайте свою беглость.';

  @override
  String get aiAssistantTitle => 'Ассистент ИИ';

  @override
  String get aiAssistantDescription =>
      'Учитесь с помощью нашего интеллектуального ассистента.';

  @override
  String get greetingMorning => 'Доброе утро';

  @override
  String get greetingAfternoon => 'Добрый день';

  @override
  String get greetingEvening => 'Добрый вечер';

  @override
  String get italianLanguage => 'Italiano';

  @override
  String get galicianLanguage => 'Galego';

  @override
  String get portugueseLanguage => 'Português';

  @override
  String get turkishLanguage => 'Türkçe';

  @override
  String get russianLanguage => 'Русский';

  @override
  String get frenchLanguage => 'Français';
}
