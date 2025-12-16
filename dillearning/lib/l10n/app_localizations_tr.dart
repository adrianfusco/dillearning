// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Diller Öğrenme';

  @override
  String get welcome => 'Dillearning\'e Hoş Geldiniz!';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Dil';

  @override
  String get selectLanguage => 'Dil Seçin';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get startLearningLanguage => 'Dil Öğrenmeye Başla';

  @override
  String get chatWithAI => 'Pratik Yapmak İçin AI ile Sohbet Et';

  @override
  String get translator => 'Çevirmen';

  @override
  String get translatorTitle => 'Çevirmen';

  @override
  String get fromLabel => 'From';

  @override
  String get toLabel => 'To';

  @override
  String get textToTranslateLabel => 'Çevrilecek metni girin';

  @override
  String get sameLanguageError => 'Kaynak ve hedef diller aynı olamaz';

  @override
  String get translationError => 'Metin çevirisi hatası';

  @override
  String get translationResultLabel => 'Çeviri:';

  @override
  String get translateButton => 'Çevir';

  @override
  String get emptyTextFieldError => 'Lütfen çevrilecek bir metin girin';

  @override
  String get dillearningAiIsThinking => 'Dillearning AI düşünüyor...';

  @override
  String get chatWithDillearningAiTitle =>
      'Dillearning AI ile sohbet edin. Pratik yapmak için herhangi bir konu hakkında konuşabilirsiniz';

  @override
  String get somethingWentWrong =>
      'Bir şeyler yanlış gitti. Lütfen tekrar deneyin.';

  @override
  String get retryButton => 'Tekrar Dene';

  @override
  String get noCoursesAvailable => 'Mevcut kurs yok.';

  @override
  String get courseDetailsTitle => 'Kurs Detayları';

  @override
  String errorWithMessage(String message) {
    return 'Hata: $message';
  }

  @override
  String get noCourseDataAvailable => 'Kurs verisi mevcut değil.';

  @override
  String unitOrder(String order) {
    return 'Birim $order';
  }

  @override
  String get selectCourseTitle => 'Bir Kurs Seçin';

  @override
  String get chooseLanguageToLearnTitle => 'Öğreneceğiniz dili seçin';

  @override
  String get noLanguagesAvailable => 'Mevcut dil yok.';

  @override
  String get unitsTitle => 'Birimler';

  @override
  String get noUnitsAvailableForCourse => 'Bu kurs için birim bulunmuyor.';

  @override
  String get unitDetailsTitle => 'Birim Detayları';

  @override
  String get noUnitDataAvailable => 'Birim verisi mevcut değil.';

  @override
  String get generateAiExamplesButton => 'AI Örnekleri Oluştur';

  @override
  String get generateAiExerciseButton => 'AI Egzersizi Oluştur';

  @override
  String exercisePrompt(String prompt) {
    return 'Egzersiz: $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'Bu kavram için egzersiz mevcut değil.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return '\"$concept\" için AI tarafından oluşturulan egzersiz';
  }

  @override
  String get noExerciseGenerated => 'Oluşturulmuş egzersiz yok.';

  @override
  String get closeButton => 'Kapat';

  @override
  String aiExamplesForWord(String word) {
    return '\"$word\" için AI Örnekleri';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Desteklenmeyen egzersiz türü: $type';
  }

  @override
  String get checkAnswerButton => 'Cevabı Kontrol Et';

  @override
  String get checkSentenceButton => 'Cümleyi Kontrol Et';

  @override
  String get registrationSuccessful => 'Kayıt Başarılı';

  @override
  String registrationFailed(String error) {
    return 'Kayıt Başarısız: $error';
  }

  @override
  String get registerInDillearningTitle => 'Dillearning\'e Kaydol';

  @override
  String get registerButton => 'Kaydol';

  @override
  String failedToLogin(String error) {
    return 'Giriş yapılamadı: $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Dillearning\'e Hoş Geldiniz';

  @override
  String get loginButton => 'Giriş Yap';

  @override
  String get englishLanguage => 'İngilizce';

  @override
  String get spanishLanguage => 'İspanyolca';

  @override
  String get noExamplesGenerated => 'Hiç örnek oluşturulmadı.';

  @override
  String get profile => 'Profil';

  @override
  String get learning => 'Öğrenme';

  @override
  String get availableCourses => 'Mevcut Kurslar';

  @override
  String get withDillearningYouCan => 'Dillearning ile şunları yapabilirsiniz';

  @override
  String get learnLanguagesTitle => 'Diller Öğren';

  @override
  String get learnLanguagesDescription =>
      'Daha fazla dil öğrenerek ufkunuzu genişletin.';

  @override
  String get translateTextTitle => 'Metin Çevirisi';

  @override
  String get translateTextDescription =>
      'Gelişmiş yapay zeka ile doğru çeviriler.';

  @override
  String get chatPracticeTitle => 'Sohbetle Pratik Yap';

  @override
  String get chatPracticeDescription =>
      'Dillearning ile konuşarak akıcılığınızı artırın.';

  @override
  String get aiAssistantTitle => 'Yapay Zeka Asistanı';

  @override
  String get aiAssistantDescription => 'Yapay zeka asistanımızla öğrenin.';

  @override
  String get greetingMorning => 'Günaydın';

  @override
  String get greetingAfternoon => 'İyi Günler';

  @override
  String get greetingEvening => 'İyi Akşamlar';

  @override
  String get italianLanguage => 'İtalyanca';

  @override
  String get galicianLanguage => 'Galiçyaca';

  @override
  String get portugueseLanguage => 'Portekizce';

  @override
  String get turkishLanguage => 'Türkçe';

  @override
  String get russianLanguage => 'Русский';

  @override
  String get frenchLanguage => 'Français';
}
