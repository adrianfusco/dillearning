import 'dart:convert';
import 'package:dillearning/core/env_config.dart';
import 'package:dillearning/core/services/exceptions.dart';
import 'package:dillearning/core/services/session_service.dart';
import 'package:dillearning/features/auth/models/user.dart';
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:dillearning/features/learn_language/models/exercise.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final String _baseUrl = AppConfig.config.apiBaseUrl;
  final SessionService _sessionService = SessionService();

  static const Map<String, String> _endpoints = {
    'register': '/register/',
    'login': '/login/',
    'logout': '/logout',
    'chat': '/ai/chat',
    'translate': '/ai/translate',
    'explain-grammar': '/ai/explain-grammar',
    'create-examples': '/ai/create-examples',
    'generate-exercise': '/ai/generate-exercise',
    'courses': '/courses',
    'available-languages': '/available-languages',
  };

  Future<http.Response> _handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      await _sessionService.clearSession();
      throw SessionExpiredException('Session expired. Please log in again.');
    } else {
      throw Exception('Failed to load data: ${response.body}');
    }
  }

  Stream<String> streamExamples(String word, String language) async* {
    final request = http.Request(
      'POST',
      Uri.parse('$_baseUrl${_endpoints['create-examples']}'),
    );
    request.headers.addAll(await _getHeaders());
    request.body = jsonEncode(<String, String>{
      'word': word,
      'language': language,
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      await for (var chunk in response.stream.transform(utf8.decoder)) {
        yield chunk;
      }
    } else if (response.statusCode == 401) {
      await _sessionService.clearSession();
      throw SessionExpiredException('Session expired. Please log in again.');
    } else {
      throw Exception('Failed to stream examples: ${response.reasonPhrase}');
    }
  }

  Stream<String> streamExercise(String concept) async* {
    final request = http.Request(
      'POST',
      Uri.parse('$_baseUrl${_endpoints['generate-exercise']}'),
    );
    request.headers.addAll(await _getHeaders());
    request.body = jsonEncode(<String, String>{
      'concept': concept,
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      await for (var chunk in response.stream.transform(utf8.decoder)) {
        yield chunk;
      }
    } else if (response.statusCode == 401) {
      await _sessionService.clearSession();
      throw SessionExpiredException('Session expired. Please log in again.');
    } else {
      throw Exception('Failed to stream exercise: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      final user = User.fromJson(jsonDecode(userString));
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${user.tokenType} ${user.accessToken}',
      };
    }
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future<void> logout() async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['logout']}'),
      headers: await _getHeaders(),
    );
    await _handleResponse(response);
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['register']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    final handledResponse = await _handleResponse(response);
    return jsonDecode(handledResponse.body);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['login']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final handledResponse = await _handleResponse(response);
    return jsonDecode(handledResponse.body);
  }

  Future<String> chat(String question, String userId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['chat']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{
        'question': question,
        'user_id': userId,
      }),
    );
    final handledResponse = await _handleResponse(response);
    return handledResponse.body;
  }

  Future<String> translate(
      String sourceLanguage, String targetLanguage, String text) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['translate']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{
        'source_language': sourceLanguage,
        'target_language': targetLanguage,
        'text': text,
      }),
    );
    final handledResponse = await _handleResponse(response);
    return handledResponse.body;
  }

  Future<String> explainGrammar(String sentence) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['explain-grammar']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{
        'sentence': sentence,
      }),
    );
    final handledResponse = await _handleResponse(response);
    return handledResponse.body;
  }

  Future<String> createExamples(String word, String language) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['create-examples']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{'word': word, 'language': language}),
    );
    final handledResponse = await _handleResponse(response);
    return handledResponse.body;
  }

  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$_baseUrl${_endpoints['courses']}'), headers: await _getHeaders());
    final handledResponse = await _handleResponse(response);
    List jsonResponse = json.decode(handledResponse.body);
    return jsonResponse.map((course) => Course.fromJson(course)).toList();
  }

  Future<Course> getCourse(int courseId) async {
    final response = await http.get(Uri.parse('$_baseUrl/courses/$courseId'), headers: await _getHeaders());
    final handledResponse = await _handleResponse(response);
    return Course.fromJson(jsonDecode(handledResponse.body));
  }

  Future<List<Unit>> getUnits(int courseId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/courses/$courseId/units'), headers: await _getHeaders());
    final handledResponse = await _handleResponse(response);
    List jsonResponse = json.decode(handledResponse.body);
    return jsonResponse.map((unit) => Unit.fromJson(unit)).toList();
  }

  Future<Unit> getUnit(int unitId) async {
    final response = await http.get(Uri.parse('$_baseUrl/units/$unitId'), headers: await _getHeaders());
    final handledResponse = await _handleResponse(response);
    return Unit.fromJson(jsonDecode(handledResponse.body));
  }

  Future<List<Exercise>> getExercises(int conceptId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/concepts/$conceptId/exercises'), headers: await _getHeaders());
    final handledResponse = await _handleResponse(response);
    List jsonResponse = json.decode(handledResponse.body);
    return jsonResponse
        .map((exercise) => Exercise.fromJson(exercise))
        .toList();
  }

  Future<List<Course>> getAvailableCourses() async {
    final response = await http.get(Uri.parse('$_baseUrl${_endpoints['courses']}'), headers: await _getHeaders());
    final handledResponse = await _handleResponse(response);
    final data = jsonDecode(handledResponse.body) as List;
    return data.map((course) => Course.fromJson(course)).toList();
  }

  Future<double> getCourseProgress(int courseId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/courses/$courseId/progress'),
      headers: await _getHeaders(),
    );
    final handledResponse = await _handleResponse(response);
    return jsonDecode(handledResponse.body);
  }

  Future<List<int>> getUnitProgress(int unitId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/units/$unitId/progress'),
      headers: await _getHeaders(),
    );
    final handledResponse = await _handleResponse(response);
    final List<dynamic> data = jsonDecode(handledResponse.body);
    return data.cast<int>().toList();
  }

  Future<bool> canAccessUnit(int unitId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/units/$unitId/access'),
      headers: await _getHeaders(),
    );
    final handledResponse = await _handleResponse(response);
    return jsonDecode(handledResponse.body);
  }

  Future<bool> completeExercise(int exerciseId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/exercises/$exerciseId/complete'),
      headers: await _getHeaders(),
    );
    final handledResponse = await _handleResponse(response);
    final data = jsonDecode(handledResponse.body);
    return data['unit_completed'] ?? false;
  }
}
