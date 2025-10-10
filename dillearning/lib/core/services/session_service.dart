import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _keyUserId = 'userId';
  static const _keyUserName = 'userName';

  Future<void> saveSession(int userId, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, userId);
    await prefs.setString(_keyUserName, userName);
  }

  Future<Map<String, String?>> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(_keyUserId);
    final userName = prefs.getString(_keyUserName);
    return {'userId': userId?.toString(), 'userName': userName};
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserName);
  }
}
