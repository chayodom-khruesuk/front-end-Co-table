import 'package:shared_preferences/shared_preferences.dart';

class Token {
  const Token._();

  static const String _tokenKey = 'TOKEN';

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  static Future<void> setUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  static Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id') ?? 0;
  }

  static Future<void> setRoomId(int roomId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('room_id', roomId);
  }

  static Future<int> getRoomId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('room_id') ?? 0;
  }

  static Future<void> setTableId(int tableId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('table_id', tableId);
  }

  static Future<int> getTableId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('table_id') ?? 0;
  }
}
