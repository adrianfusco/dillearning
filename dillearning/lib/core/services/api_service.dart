import 'dart:convert';
import 'package:dillearning/core/env_config.dart';
import 'package:dillearning/features/learn_language/models/course.dart';
import 'package:dillearning/features/learn_language/models/unit.dart';
import 'package:dillearning/features/learn_language/models/lesson.dart';
import 'package:dillearning/features/learn_language/models/exercise.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // La URL base de la API se obtiene de la configuración de la aplicación
  static final String _baseUrl = AppConfig.config.apiBaseUrl;

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
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

  Future<String> translate(
      String sourceLanguage, String targetLanguage, String text) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/ai/translate'),
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
      Uri.parse('$_baseUrl/ai/explain-grammar'),
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
      Uri.parse('$_baseUrl/ai/create-examples'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'word': word, 'language': language}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed: ${response.body}');
    }
  }

  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$_baseUrl/courses'));

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

  Future<List<Lesson>> getLessons(int unitId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/units/$unitId/lessons'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((lesson) => Lesson.fromJson(lesson)).toList();
    } else {
      throw Exception('Failed to load lessons');
    }
  }

  Future<List<Exercise>> getExercises(int lessonId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/lessons/$lessonId/exercises'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((exercise) => Exercise.fromJson(exercise))
          .toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAvailableLanguages() async {
    final response = await http.get(Uri.parse('$_baseUrl/available-languages'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> languages = data['available_languages'];

      return languages.map((language) {
        return {
          'code': language['code'],
          'name': language['name'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load languages: ${response.body}');
    }
  }
}
