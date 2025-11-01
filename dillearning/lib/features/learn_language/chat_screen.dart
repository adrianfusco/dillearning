import 'package:dillearning/core/services/api_service.dart';
import 'package:dillearning/core/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = InMemoryChatController();
  User _user = const User(id: '0', name: 'User');
  final _ai = const User(id: 'ai', name: 'DilLearning AI');
  final _apiService = ApiService();
  final _uuid = const Uuid();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final session = await SessionService().getSession();
    if (session != null) {
      final loadedUser = User(
        id: session.id.toString(),
        name: session.name,
      );
      setState(() {
        _user = loadedUser;
      });

      _addMessage(
        'Hola ${loadedUser.name}, bienvenido. Soy tu compañero de práctica de idiomas, Dil. '
        'Puedes pedirme traducciones, explicaciones de gramática o simplemente tener una conversación en inglés o español. '
        '¿Con qué te gustaría empezar?',
        author: _ai,
      );
    }
  }

  Future<void> _handleMessageSend(String text) async {
    if (text.isEmpty) return;

    _addMessage(text, author: _user);
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiService.chat(text, _user.id);
      _addMessage(response, author: _ai);
    } catch (e) {
      _addMessage('Error: $e', author: _ai);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addMessage(String text, {required User author}) {
    final message = TextMessage(
      id: _uuid.v4(),
      authorId: author.id,
      createdAt: DateTime.now().toUtc(),
      text: text,
    );
    _chatController.insertMessage(message);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildChatBody(),
          if (_isLoading)
            const Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('DilLearning IA está pensando...'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Chat con Dillearning IA. Puedes hablar de cualquier tema para ejercitar tu aprendizaje'),
    );
  }

  Widget _buildChatBody() {
    return Chat(
      chatController: _chatController,
      currentUserId: _user.id,
      onMessageSend: _handleMessageSend,
      resolveUser: (userID) async {
        return userID == _user.id ? _user : _ai;
      },
    );
  }
}
