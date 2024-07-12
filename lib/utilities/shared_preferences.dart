import 'package:shared_preferences/shared_preferences.dart';

// ----setUserID-----
Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

// ----getUserIG------
Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

// ----clearUserId------
Future<void> clearUserId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
}
