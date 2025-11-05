import 'dart:convert';
import 'package:dillearning/core/env_config.dart';
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:dillearning/features/learn_language/models/exercise.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = AppConfig.config.apiBaseUrl;

  static const Map<String, String> _endpoints = {
    'register': '/register/',
    'login': '/login/',
    'chat': '/ai/chat',
    'translate': '/ai/translate',
    'explain-grammar': '/ai/explain-grammar',
    'create-examples': '/ai/create-examples',
    'courses': '/courses',
    'available-languages': '/available-languages',
  };

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['register']}'),
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
      Uri.parse('$_baseUrl${_endpoints['login']}'),
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
      Uri.parse('$_baseUrl${_endpoints['chat']}'),
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

  Future<String> translate(
      String sourceLanguage, String targetLanguage, String text) async {
    final response = await http.post(
      Uri.parse('$_baseUrl${_endpoints['translate']}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
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
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
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
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
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
    final response = await http.get(Uri.parse('$_baseUrl${_endpoints['courses']}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses: ${response.body}');
    }
  }

  Future<Course> getCourse(int courseId) async {
    final response = await http.get(Uri.parse('$_baseUrl/courses/$courseId'));

    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course: ${response.body}');
    }
  }

  Future<List<Unit>> getUnits(int courseId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/courses/$courseId/units'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((unit) => Unit.fromJson(unit)).toList();
    } else {
      throw Exception('Failed to load units');
    }
  }

  Future<Unit> getUnit(int unitId) async {
    final response = await http.get(Uri.parse('$_baseUrl/units/$unitId'));

    if (response.statusCode == 200) {
      return Unit.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load unit');
    }
  }

  Future<List<Exercise>> getExercises(int conceptId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/concepts/$conceptId/exercises'));

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
    final response = await http.get(Uri.parse('$_baseUrl${_endpoints['available-languages']}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load languages: ${response.body}');
    }
  }
}
