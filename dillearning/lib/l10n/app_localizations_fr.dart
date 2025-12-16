// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Apprentissage des Langues';

  @override
  String get welcome => 'Bienvenue sur Dillearning !';

  @override
  String get theme => 'Thème';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

  @override
  String get logout => 'Se Déconnecter';

  @override
  String get startLearningLanguage => 'Commencer à Apprendre une Langue';

  @override
  String get chatWithAI => 'Discuter avec l\'IA pour pratiquer';

  @override
  String get translator => 'Traducteur';

  @override
  String get translatorTitle => 'Traducteur';

  @override
  String get fromLabel => 'De';

  @override
  String get toLabel => 'À';

  @override
  String get textToTranslateLabel => 'Entrez le texte à traduire';

  @override
  String get sameLanguageError =>
      'Les langues source et cible ne peuvent pas être identiques';

  @override
  String get translationError => 'Erreur lors de la traduction du texte';

  @override
  String get translationResultLabel => 'Traduction :';

  @override
  String get translateButton => 'Traduire';

  @override
  String get emptyTextFieldError => 'Veuillez entrer un texte à traduire';

  @override
  String get dillearningAiIsThinking => 'L\'IA de DilLearning réfléchit...';

  @override
  String get chatWithDillearningAiTitle =>
      'Discuter avec l\'IA de Dillearning. Vous pouvez parler de n\'importe quel sujet pour pratiquer votre apprentissage';

  @override
  String get somethingWentWrong =>
      'Quelque chose s\'est mal passé. Veuillez réessayer.';

  @override
  String get retryButton => 'Réessayer';

  @override
  String get noCoursesAvailable => 'Aucun cours disponible.';

  @override
  String get courseDetailsTitle => 'Détails du Cours';

  @override
  String errorWithMessage(String message) {
    return 'Erreur : $message';
  }

  @override
  String get noCourseDataAvailable => 'Aucune donnée de cours disponible.';

  @override
  String unitOrder(String order) {
    return 'Unité $order';
  }

  @override
  String get selectCourseTitle => 'Sélectionner un Cours';

  @override
  String get chooseLanguageToLearnTitle => 'Choisissez une langue à apprendre';

  @override
  String get noLanguagesAvailable => 'Aucune langue disponible.';

  @override
  String get unitsTitle => 'Unités';

  @override
  String get noUnitsAvailableForCourse =>
      'Aucune unité disponible pour ce cours.';

  @override
  String get unitDetailsTitle => 'Détails de l\'Unité';

  @override
  String get noUnitDataAvailable => 'Aucune donnée d\'unité disponible.';

  @override
  String get generateAiExamplesButton => 'Générer des Exemples IA';

  @override
  String get generateAiExerciseButton => 'Générer un Exercice IA';

  @override
  String exercisePrompt(String prompt) {
    return 'Exercice : $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'Aucun exercice disponible pour ce concept.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return 'Exercice généré par IA pour \"$concept\"';
  }

  @override
  String get noExerciseGenerated => 'Aucun exercice généré.';

  @override
  String get closeButton => 'Fermer';

  @override
  String aiExamplesForWord(String word) {
    return 'Exemples IA pour \"$word\"';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Type d\'exercice non pris en charge : $type';
  }

  @override
  String get checkAnswerButton => 'Vérifier la Réponse';

  @override
  String get checkSentenceButton => 'Vérifier la Phrase';

  @override
  String get registrationSuccessful => 'Inscription réussie';

  @override
  String registrationFailed(String error) {
    return 'Échec de l\'inscription : $error';
  }

  @override
  String get registerInDillearningTitle => 'Inscription à Dillearning';

  @override
  String get registerButton => 'S\'inscrire';

  @override
  String failedToLogin(String error) {
    return 'Échec de la connexion : $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Bienvenue sur Dillearning';

  @override
  String get loginButton => 'Se Connecter';

  @override
  String get englishLanguage => 'English';

  @override
  String get spanishLanguage => 'Español';

  @override
  String get noExamplesGenerated => 'Aucun exemple généré.';

  @override
  String get profile => 'Profil';

  @override
  String get learning => 'Apprentissage';

  @override
  String get availableCourses => 'Cours Disponibles';

  @override
  String get withDillearningYouCan => 'Avec Dillearning vous pouvez';

  @override
  String get learnLanguagesTitle => 'Apprendre des Langues';

  @override
  String get learnLanguagesDescription =>
      'Élargissez vos horizons en apprenant plusieurs langues.';

  @override
  String get translateTextTitle => 'Traduire des Textes';

  @override
  String get translateTextDescription =>
      'Traductions précises avec IA avancée.';

  @override
  String get chatPracticeTitle => 'Pratiquer avec un Chat';

  @override
  String get chatPracticeDescription =>
      'Discutez avec Dillearning et améliorez votre fluidité.';

  @override
  String get aiAssistantTitle => 'Assistant IA';

  @override
  String get aiAssistantDescription =>
      'Apprenez avec l\'aide de notre assistant intelligent.';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon Après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

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
