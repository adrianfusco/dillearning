import 'dart:convert';
import 'package:dillearning/core/env_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // La URL base de la API se obtiene de la configuración de la aplicación
  final String _baseUrl = AppConfig.config.apiBaseUrl;

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<String> chat(String question, String userId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/ai/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'question': question,
        'user_id': userId,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed: ${response.body}');
    }
  }
}
