// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class AppLocalizationsGl extends AppLocalizations {
  AppLocalizationsGl([String locale = 'gl']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Aprendizaxe de Idiomas';

  @override
  String get welcome => 'Benvido a Dillearning!';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get logout => 'Pechar sesión';

  @override
  String get startLearningLanguage => 'Comeza a aprender un idioma';

  @override
  String get chatWithAI => 'Charlar co AI para practicar';

  @override
  String get translator => 'Tradutor';

  @override
  String get translatorTitle => 'Tradutor';

  @override
  String get fromLabel => 'De';

  @override
  String get toLabel => 'A';

  @override
  String get textToTranslateLabel => 'Introduce o texto a traducir';

  @override
  String get sameLanguageError =>
      'As linguas de orixe e destino non poden ser as mesmas';

  @override
  String get translationError => 'Erro ao traducir o texto';

  @override
  String get translationResultLabel => 'Traducción:';

  @override
  String get translateButton => 'Traducir';

  @override
  String get emptyTextFieldError =>
      'Por favor, introduce algún texto para traducir';

  @override
  String get dillearningAiIsThinking => 'A IA de DilLearning está pensando...';

  @override
  String get chatWithDillearningAiTitle =>
      'Charla coa IA de Dillearning. Podes falar de calquera tema para practicar o teu aprendizaxe';

  @override
  String get somethingWentWrong =>
      'Algo fixo mal. Por favor, inténtao de novo.';

  @override
  String get retryButton => 'Reintentar';

  @override
  String get noCoursesAvailable => 'Non hai cursos dispoñibles.';

  @override
  String get courseDetailsTitle => 'Detalles do curso';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get noCourseDataAvailable => 'Non hai datos de cursos dispoñibles.';

  @override
  String unitOrder(String order) {
    return 'Unidade $order';
  }

  @override
  String get selectCourseTitle => 'Selecciona un curso';

  @override
  String get chooseLanguageToLearnTitle => 'Elixe un idioma para aprender';

  @override
  String get noLanguagesAvailable => 'Non hai idiomas dispoñibles.';

  @override
  String get unitsTitle => 'Unidades';

  @override
  String get noUnitsAvailableForCourse =>
      'Non hai unidades dispoñibles para este curso.';

  @override
  String get unitDetailsTitle => 'Detalles da unidade';

  @override
  String get noUnitDataAvailable => 'Non hai datos da unidade dispoñibles.';

  @override
  String get generateAiExamplesButton => 'Xerar exemplos AI';

  @override
  String get generateAiExerciseButton => 'Xerar exercicio AI';

  @override
  String exercisePrompt(String prompt) {
    return 'Exercicio: $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'Non hai exercicios dispoñibles para este concepto.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return 'Exercicio Xerado por AI para \"$concept\"';
  }

  @override
  String get noExerciseGenerated => 'Non se xerou ningún exercicio.';

  @override
  String get closeButton => 'Pechar';

  @override
  String aiExamplesForWord(String word) {
    return 'Exemplos AI para \"$word\"';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Tipo de exercicio non soportado: $type';
  }

  @override
  String get checkAnswerButton => 'Verificar resposta';

  @override
  String get checkSentenceButton => 'Verificar frase';

  @override
  String get registrationSuccessful => 'Rexistro exitoso';

  @override
  String registrationFailed(String error) {
    return 'Rexistro fallido: $error';
  }

  @override
  String get registerInDillearningTitle => 'Rexístrate en Dillearning';

  @override
  String get registerButton => 'Rexístrate';

  @override
  String failedToLogin(String error) {
    return 'Non se puido iniciar sesión: $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Benvido a Dillearning';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get englishLanguage => 'Inglés';

  @override
  String get spanishLanguage => 'Español';

  @override
  String get noExamplesGenerated => 'Non se xeraron exemplos.';

  @override
  String get profile => 'Perfil';

  @override
  String get learning => 'Aprendizaxe';

  @override
  String get availableCourses => 'Cursos dispoñibles';

  @override
  String get withDillearningYouCan => 'Con Dillearning podes';

  @override
  String get learnLanguagesTitle => 'Aprender idiomas';

  @override
  String get learnLanguagesDescription =>
      'Expande os teus horizontes aprendendo múltiples idiomas.';

  @override
  String get translateTextTitle => 'Traducir textos';

  @override
  String get translateTextDescription => 'Traducción precisa con IA avanzada.';

  @override
  String get chatPracticeTitle => 'Practicar cunha charla';

  @override
  String get chatPracticeDescription =>
      'Fala con Dillearning e mellora a túa fluidez.';

  @override
  String get aiAssistantTitle => 'Asistente IA';

  @override
  String get aiAssistantDescription =>
      'Aprende coa axuda do noso asistente intelixente.';

  @override
  String get greetingMorning => 'Bos días';

  @override
  String get greetingAfternoon => 'Boas tardes';

  @override
  String get greetingEvening => 'Boa noite';

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
