import 'package:shared_preferences/shared_preferences.dart';

class FileUtils {
  // حفظ معلومات تسجيل الدخول
  static Future<void> saveLoginInfo(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username') && prefs.containsKey('password')) {
      print('⚠️ Login info already exists, skipping save.');
      return;
    }
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    print('✅ Login info saved in SharedPreferences');
  }

  // قراءة معلومات تسجيل الدخول
  static Future<Map<String, String>?> readLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    if (username != null && password != null) {
      return {'username': username, 'password': password};
    }
    return null;
  }

  // مسح معلومات تسجيل الدخول
  static Future<void> clearLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    print('🧹 Login info cleared from SharedPreferences');
  }
}
