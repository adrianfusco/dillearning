import 'dart:convert';
import 'package:dillearning/features/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _keyUser = 'user';

  Future<void> saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  Future<User?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_keyUser);
    if (userString != null) {
      return User.fromJson(jsonDecode(userString));
    }
    return null;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }

  Future<bool> isLoggedIn() async {
    final user = await getSession();
    return user != null;
  }
}
