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
  String get emptyTextFieldError =>
      'Por favor, introduce algún texto para traducir';

  @override
  String get dillearningAiIsThinking => 'Dillearning IA está pensando...';

  @override
  String get chatWithDillearningAiTitle =>
      'Charla con Dillearning IA. Puedes hablar de cualquier tema para ejercitar tu aprendizaje';

  @override
  String get somethingWentWrong =>
      'Algo salió mal. Por favor, inténtalo de nuevo.';

  @override
  String get retryButton => 'Reintentar';

  @override
  String get noCoursesAvailable => 'No hay cursos disponibles.';

  @override
  String get courseDetailsTitle => 'Detalles del Curso';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get noCourseDataAvailable => 'No hay datos de curso disponibles.';

  @override
  String unitOrder(String order) {
    return 'Unidad $order';
  }

  @override
  String get selectCourseTitle => 'Selecciona un Curso';

  @override
  String get chooseLanguageToLearnTitle => 'Elige un idioma para aprender';

  @override
  String get noLanguagesAvailable => 'No hay idiomas disponibles.';

  @override
  String get unitsTitle => 'Unidades';

  @override
  String get noUnitsAvailableForCourse =>
      'No hay unidades disponibles para este curso.';

  @override
  String get unitDetailsTitle => 'Detalles de la Unidad';

  @override
  String get noUnitDataAvailable => 'No hay datos de unidad disponibles.';

  @override
  String get generateAiExamplesButton => 'Generar Ejemplos de IA';

  @override
  String get generateAiExerciseButton => 'Generar Ejercicio de IA';

  @override
  String exercisePrompt(String prompt) {
    return 'Ejercicio: $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'No hay ejercicios disponibles para este concepto.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return 'Ejercicio Generado por IA para \"$concept\"';
  }

  @override
  String get noExerciseGenerated => 'No se generó ningún ejercicio.';

  @override
  String get closeButton => 'Cerrar';

  @override
  String aiExamplesForWord(String word) {
    return 'Ejemplos de IA para \"$word\"';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Tipo de ejercicio no compatible: $type';
  }

  @override
  String get checkAnswerButton => 'Comprobar Respuesta';

  @override
  String get checkSentenceButton => 'Comprobar Frase';

  @override
  String get registrationSuccessful => 'Registro exitoso';

  @override
  String registrationFailed(String error) {
    return 'Registro fallido: $error';
  }

  @override
  String get registerInDillearningTitle => 'Registrarse en dillearning';

  @override
  String get registerButton => 'Registrarse';

  @override
  String failedToLogin(String error) {
    return 'Error al iniciar sesión: $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Bienvenido a dillearning';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get englishLanguage => 'Inglés';

  @override
  String get spanishLanguage => 'Español';

  @override
  String get noExamplesGenerated => 'No se generaron ejemplos.';

  @override
  String get profile => 'Perfil';

  @override
  String get learning => 'Aprendizaje';

  @override
  String get availableCourses => 'Cursos disponibles';

  @override
  String get withDillearningYouCan => 'Con dillearning puedes';

  @override
  String get learnLanguagesTitle => 'Aprende Idiomas';

  @override
  String get learnLanguagesDescription =>
      'Expande tus horizontes aprendiendo varios idiomas.';

  @override
  String get translateTextTitle => 'Traduce Textos';

  @override
  String get translateTextDescription =>
      'Traducciones precisas con IA avanzada.';

  @override
  String get chatPracticeTitle => 'Práctica con un Chat';

  @override
  String get chatPracticeDescription =>
      'Habla con Dillarning y mejora tu fluidez.';

  @override
  String get aiAssistantTitle => 'Asistente IA';

  @override
  String get aiAssistantDescription =>
      'Aprende con ayuda de nuestro asistente inteligente.';

  @override
  String get greetingMorning => 'Buenos Días';

  @override
  String get greetingAfternoon => 'Buenas Tardes';

  @override
  String get greetingEvening => 'Buenas Noches';
}
