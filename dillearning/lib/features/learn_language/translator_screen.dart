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
  String? _sourceLanguage = 'English';
  String? _targetLanguage = 'Español';
  String _translatedText = '';
  bool _isLoading = false;
  final List<String> _languages = <String>['English', 'Español', 'Italiano'];

  Future<void> _handleTranslation() async {
    final text = _textController.text;
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.emptyTextFieldError),
        ),
      );
      return;
    }

    if (_sourceLanguage == null || _targetLanguage == null) {
      return;
    }

    if (_sourceLanguage == _targetLanguage) {
      setState(() {
        _translatedText = AppLocalizations.of(context)!.sameLanguageError;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

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
    } finally {
      setState(() {
        _isLoading = false;
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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translatorTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLanguageSelector(
                            AppLocalizations.of(context)!.fromLabel,
                            _sourceLanguage,
                            (val) {
                              setState(() {
                                _sourceLanguage = val;
                              });
                            },
                          ),
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
                            AppLocalizations.of(context)!.toLabel,
                            _targetLanguage,
                            (val) {
                              setState(() {
                                _targetLanguage = val;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!
                              .textToTranslateLabel,
                        ),
                        minLines: 3,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _handleTranslation,
                  icon: _isLoading
                      ? const SizedBox.shrink()
                      : const Icon(Icons.translate),
                  label: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(AppLocalizations.of(context)!.translateButton),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_translatedText.isNotEmpty)
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(
    String label,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
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
