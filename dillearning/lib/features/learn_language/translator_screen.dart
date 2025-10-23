import 'package:dillearning/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/l10n/app_localizations.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final _apiService = ApiService();
  final _textController = TextEditingController();
  // Los colocamos por defecto
  String? _sourceLanguage = 'English';
  String? _targetLanguage = 'Español';
  String _translatedText = '';
  // Aunque el modelo entiende más idiomas, coloco estos por defecto:
  final List<String> _languages = <String>['English', 'Español', 'Italiano'];

  Future<void> _handleTranslation() async {
    final text = _textController.text;
    if (_sourceLanguage == null || _targetLanguage == null || text.isEmpty) {
      return;
    }

    if (_sourceLanguage == _targetLanguage) {
      setState(() {
        _translatedText = AppLocalizations.of(context)!.sameLanguageError;
      });
      return;
    }

    try {
      final response = await _apiService.translate(
        _sourceLanguage!,
        _targetLanguage!,
        text,
      );
      setState(() {
        _translatedText = response;
      });
    } catch (e) {
      setState(() {
        _translatedText = AppLocalizations.of(context)!.translationError;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildTranslatorBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.translatorTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTranslatorBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLanguageSelector(
                    AppLocalizations.of(context)!.fromLabel, _sourceLanguage,
                    (val) {
                  setState(() {
                    _sourceLanguage = val;
                  });
                }),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: () {
                    setState(() {
                      final temp = _sourceLanguage;
                      _sourceLanguage = _targetLanguage;
                      _targetLanguage = temp;
                    });
                  },
                ),
                _buildLanguageSelector(
                    AppLocalizations.of(context)!.toLabel, _targetLanguage,
                    (val) {
                  setState(() {
                    _targetLanguage = val;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.textToTranslateLabel,
              ),
              minLines: 3,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleTranslation,
              child: Text(AppLocalizations.of(context)!.translateButton),
            ),
            const SizedBox(height: 20),
            if (_translatedText.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translationResultLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _translatedText,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(
      String label, String? value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: value,
          elevation: 16,
          style: TextStyle(color: Theme.of(context).primaryColor),
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColorDark,
          ),
          onChanged: onChanged,
          items: _languages.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
