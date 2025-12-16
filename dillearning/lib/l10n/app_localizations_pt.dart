// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Dillearning - Aprendizagem de Idiomas';

  @override
  String get welcome => 'Bem-vindo ao Dillearning!';

  @override
  String get theme => 'Tema';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Selecionar Idioma';

  @override
  String get logout => 'Sair';

  @override
  String get startLearningLanguage => 'Comece a Aprender Idioma';

  @override
  String get chatWithAI => 'Converse com a IA para praticar';

  @override
  String get translator => 'Tradutor';

  @override
  String get translatorTitle => 'Tradutor';

  @override
  String get fromLabel => 'De';

  @override
  String get toLabel => 'Para';

  @override
  String get textToTranslateLabel => 'Insira o texto para traduzir';

  @override
  String get sameLanguageError =>
      'As línguas de origem e destino não podem ser as mesmas';

  @override
  String get translationError => 'Erro ao traduzir o texto';

  @override
  String get translationResultLabel => 'Tradução:';

  @override
  String get translateButton => 'Traduzir';

  @override
  String get emptyTextFieldError => 'Por favor, insira um texto para traduzir';

  @override
  String get dillearningAiIsThinking => 'A IA do DilLearning está pensando...';

  @override
  String get chatWithDillearningAiTitle =>
      'Converse com a IA do Dillearning. Você pode falar sobre qualquer assunto para praticar';

  @override
  String get somethingWentWrong => 'Algo deu errado. Tente novamente.';

  @override
  String get retryButton => 'Tentar Novamente';

  @override
  String get noCoursesAvailable => 'Nenhum curso disponível.';

  @override
  String get courseDetailsTitle => 'Detalhes do Curso';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get noCourseDataAvailable => 'Nenhum dado de curso disponível.';

  @override
  String unitOrder(String order) {
    return 'Unidade $order';
  }

  @override
  String get selectCourseTitle => 'Selecione um Curso';

  @override
  String get chooseLanguageToLearnTitle => 'Escolha um idioma para aprender';

  @override
  String get noLanguagesAvailable => 'Nenhum idioma disponível.';

  @override
  String get unitsTitle => 'Unidades';

  @override
  String get noUnitsAvailableForCourse =>
      'Nenhuma unidade disponível para este curso.';

  @override
  String get unitDetailsTitle => 'Detalhes da Unidade';

  @override
  String get noUnitDataAvailable => 'Nenhum dado de unidade disponível.';

  @override
  String get generateAiExamplesButton => 'Gerar Exemplos de IA';

  @override
  String get generateAiExerciseButton => 'Gerar Exercício de IA';

  @override
  String exercisePrompt(String prompt) {
    return 'Exercício: $prompt';
  }

  @override
  String get noExercisesAvailableForConcept =>
      'Nenhum exercício disponível para este conceito.';

  @override
  String aiGeneratedExerciseForConcept(String concept) {
    return 'Exercício Gerado pela IA para \"$concept\"';
  }

  @override
  String get noExerciseGenerated => 'Nenhum exercício gerado.';

  @override
  String get closeButton => 'Fechar';

  @override
  String aiExamplesForWord(String word) {
    return 'Exemplos de IA para \"$word\"';
  }

  @override
  String unsupportedExerciseType(String type) {
    return 'Tipo de exercício não suportado: $type';
  }

  @override
  String get checkAnswerButton => 'Verificar Resposta';

  @override
  String get checkSentenceButton => 'Verificar Frase';

  @override
  String get registrationSuccessful => 'Registro bem-sucedido';

  @override
  String registrationFailed(String error) {
    return 'Falha no registro: $error';
  }

  @override
  String get registerInDillearningTitle => 'Registrar-se no Dillearning';

  @override
  String get registerButton => 'Registrar';

  @override
  String failedToLogin(String error) {
    return 'Falha ao fazer login: $error';
  }

  @override
  String get welcomeToDillearningTitle => 'Bem-vindo ao Dillearning';

  @override
  String get loginButton => 'Entrar';

  @override
  String get englishLanguage => 'Inglês';

  @override
  String get spanishLanguage => 'Espanhol';

  @override
  String get noExamplesGenerated => 'Nenhum exemplo gerado.';

  @override
  String get profile => 'Perfil';

  @override
  String get learning => 'Aprendizado';

  @override
  String get availableCourses => 'Cursos Disponíveis';

  @override
  String get withDillearningYouCan => 'Com Dillearning você pode';

  @override
  String get learnLanguagesTitle => 'Aprender Idiomas';

  @override
  String get learnLanguagesDescription =>
      'Expanda seus horizontes aprendendo múltiplos idiomas.';

  @override
  String get translateTextTitle => 'Traduzir Textos';

  @override
  String get translateTextDescription => 'Traduções precisas com IA avançada.';

  @override
  String get chatPracticeTitle => 'Praticar com uma Conversa';

  @override
  String get chatPracticeDescription =>
      'Converse com Dillearning e melhore sua fluência.';

  @override
  String get aiAssistantTitle => 'Assistente de IA';

  @override
  String get aiAssistantDescription =>
      'Aprenda com a ajuda do nosso assistente inteligente.';

  @override
  String get greetingMorning => 'Bom Dia';

  @override
  String get greetingAfternoon => 'Boa Tarde';

  @override
  String get greetingEvening => 'Boa Noite';

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
