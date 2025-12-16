// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Imparare le Lingue';

  @override
  String get welcome => 'Benvenuto su Dillearning!';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Lingua';

  @override
  String get selectLanguage => 'Seleziona Lingua';

  @override
  String get logout => 'Esci';

  @override
  String get startLearningLanguage => 'Inizia a Imparare la Lingua';

  @override
  String get chatWithAI => 'Chatta con l\'AI per esercitarti';

  @override
  String get translator => 'Traduttore';

  @override
  String get translatorTitle => 'Traduttore';

  @override
  String get fromLabel => 'Da';

  @override
  String get toLabel => 'A';

  @override
  String get textToTranslateLabel => 'Inserisci il testo da tradurre';

  @override
  String get sameLanguageError =>
      'Le lingue di origine e destinazione non possono essere le stesse';

  @override
  String get translationError => 'Errore nella traduzione del testo';

  @override
  String get translationResultLabel => 'Traduzione:';

  @override
  String get translateButton => 'Traduci';

  @override
  String get emptyTextFieldError =>
      'Per favore, inserisci del testo da tradurre';

  @override
  String get dillearningAiIsThinking => 'L\'AI di DilLearning sta pensando...';

  @override
  String get chatWithDillearningAiTitle =>
      'Chatta con l\'AI di Dillearning. Puoi parlare di qualsiasi argomento per esercitarti';

  @override
  String get somethingWentWrong => 'Qualcosa è andato storto. Riprova.';

  @override
  String get retryButton => 'Riprova';

  @override
  String get noCoursesAvailable => 'Nessun corso disponibile.';

  @override
  String get courseDetailsTitle => 'Dettagli Corso';

  @override
  String errorWithMessage(String message) {
    return 'Errore: $message';
  }

  @override
  String get noCourseDataAvailable => 'Nessun dato corso disponibile.';

  @override
  String unitOrder(String order) {
    return 'Unità $order';
  }

  @override
  String get selectCourseTitle => 'Seleziona un Corso';

  @override
  String get chooseLanguageToLearnTitle => 'Scegli una lingua da imparare';

  @override
  String get noLanguagesAvailable => 'Nessuna lingua disponibile.';

  @override
  String get unitsTitle => 'Unità';

  @override
  String get noUnitsAvailableForCourse =>
      'Nessuna unità disponibile per questo corso.';

  @override
  String get unitDetailsTitle => 'Dettagli Unità';

  @override
  String get noUnitDataAvailable => 'Nessun dato unità disponibile.';

  @override
  String get generateAiExamplesButton => 'Genera Esempi AI';

  @override
  String get generateAiExerciseButton => 'Genera Esercizio AI';

  @override
  String exercisePrompt(String prompt) {
    return 'Esercizio: $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'Nessun esercizio disponibile per questo concetto.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return 'Esercizio Generato da AI per \"$concept\"';
  }

  @override
  String get noExerciseGenerated => 'Nessun esercizio generato.';

  @override
  String get closeButton => 'Chiudi';

  @override
  String aiExamplesForWord(String word) {
    return 'Esempi AI per \"$word\"';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Tipo di esercizio non supportato: $type';
  }

  @override
  String get checkAnswerButton => 'Verifica Risposta';

  @override
  String get checkSentenceButton => 'Verifica Frase';

  @override
  String get registrationSuccessful => 'Registrazione riuscita';

  @override
  String registrationFailed(String error) {
    return 'Registrazione fallita: $error';
  }

  @override
  String get registerInDillearningTitle => 'Registrati in Dillearning';

  @override
  String get registerButton => 'Registrati';

  @override
  String failedToLogin(String error) {
    return 'Impossibile accedere: $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Benvenuto su Dillearning';

  @override
  String get loginButton => 'Accedi';

  @override
  String get englishLanguage => 'Inglese';

  @override
  String get spanishLanguage => 'Spagnolo';

  @override
  String get noExamplesGenerated => 'Nessun esempio generato.';

  @override
  String get profile => 'Profilo';

  @override
  String get learning => 'Apprendimento';

  @override
  String get availableCourses => 'Corsi Disponibili';

  @override
  String get withDillearningYouCan => 'Con Dillearning puoi';

  @override
  String get learnLanguagesTitle => 'Impara le Lingue';

  @override
  String get learnLanguagesDescription =>
      'Espandi i tuoi orizzonti imparando più lingue.';

  @override
  String get translateTextTitle => 'Traduci Testi';

  @override
  String get translateTextDescription =>
      'Traduzioni precise con intelligenza artificiale avanzata.';

  @override
  String get chatPracticeTitle => 'Esercitati con una Chat';

  @override
  String get chatPracticeDescription =>
      'Parla con Dillearning e migliora la tua fluidità.';

  @override
  String get aiAssistantTitle => 'Assistente AI';

  @override
  String get aiAssistantDescription =>
      'Impara con l\'aiuto del nostro assistente intelligente.';

  @override
  String get greetingMorning => 'Buongiorno';

  @override
  String get greetingAfternoon => 'Buon pomeriggio';

  @override
  String get greetingEvening => 'Buona sera';

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
