import 'dart:convert';
import 'package:dillearning/core/env_config.dart';
import 'package:dillearning/features/auth/models/user.dart';
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:dillearning/features/learn_language/models/exercise.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final String _baseUrl = AppConfig.config.apiBaseUrl;

  static const Map<String, String> _endpoints = {
    'register': '/register/',
    'login': '/login/',
    'chat': '/ai/chat',
    'translate': '/ai/translate',
    'explain-grammar': '/ai/explain-grammar',
    'create-examples': '/ai/create-examples',
    'generate-exercise': '/ai/generate-exercise',
    'courses': '/courses',
    'available-languages': '/available-languages',
  };

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

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
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

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
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

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed: ${response.body}');
    }
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

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed: ${response.body}');
    }
  }

  Future<String> explainGrammar(String sentence) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['explain-grammar']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{
        'sentence': sentence,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed: ${response.body}');
    }
  }

  Future<String> createExamples(String word, String language) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['create-examples']}'),
      headers: await _getHeaders(),
      body: jsonEncode(<String, String>{'word': word, 'language': language}),
    );

    if (response.statusCode == 200) {
      return response.body;
    }
    else {
      throw Exception('Failed: ${response.body}');
    }
  }

  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$_baseUrl${_endpoints['courses']}'), headers: await _getHeaders());

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses: ${response.body}');
    }
  }

  Future<Course> getCourse(int courseId) async {
    final response = await http.get(Uri.parse('$_baseUrl/courses/$courseId'), headers: await _getHeaders());

    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course: ${response.body}');
    }
  }

  Future<List<Unit>> getUnits(int courseId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/courses/$courseId/units'), headers: await _getHeaders());

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((unit) => Unit.fromJson(unit)).toList();
    } else {
      throw Exception('Failed to load units');
    }
  }

  Future<Unit> getUnit(int unitId) async {
    final response = await http.get(Uri.parse('$_baseUrl/units/$unitId'), headers: await _getHeaders());

    if (response.statusCode == 200) {
      return Unit.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load unit');
    }
  }

  Future<List<Exercise>> getExercises(int conceptId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/concepts/$conceptId/exercises'), headers: await _getHeaders());

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((exercise) => Exercise.fromJson(exercise))
          .toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<List<Course>> getAvailableCourses() async {
    final response = await http.get(Uri.parse('$_baseUrl${_endpoints['courses']}'), headers: await _getHeaders());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load languages: ${response.body}');
    }
  }

  Future<double> getCourseProgress(int courseId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/courses/$courseId/progress'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load course progress: ${response.body}');
    }
  }

  Future<bool> canAccessUnit(int unitId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/units/$unitId/access'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check unit access: ${response.body}');
    }
  }

  Future<bool> completeExercise(int exerciseId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/exercises/$exerciseId/complete'),
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['unit_completed'] ?? false;
    } else {
      throw Exception('Failed to complete exercise: ${response.body}');
    }
  }
}
