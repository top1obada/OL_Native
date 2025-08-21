import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/LoginInfoData.txt');

    // إذا الملف مش موجود → ينشئه فاضي
    if (!await file.exists()) {
      await file.create(recursive: true);
      print('📂 File created at: ${file.absolute.path}');
    }

    return file;
  }

  static Future<void> saveLoginInfo(String username, String password) async {
    try {
      final file = await _getLocalFile();

      // اقرأ المحتوى الحالي
      final existingContent = await file.readAsString();

      // إذا الملف فيه Username/Password → لا تكتب مرة ثانية
      if (existingContent.contains('Username:') &&
          existingContent.contains('Password:')) {
        print('⚠️ Login info already exists, skipping save.');
        return;
      }

      // غير هيك → اكتب البيانات
      final content = 'Username:$username\nPassword:$password';
      await file.writeAsString(content);
      print('✅ Login info saved: ${file.absolute.path}');
    } catch (e) {
      print('❌ Error saving login info: $e');
    }
  }

  static Future<Map<String, String>?> readLoginInfo() async {
    try {
      final file = await _getLocalFile();
      final content = await file.readAsString();
      final lines = content.split('\n');
      String username = '';
      String password = '';
      for (var line in lines) {
        if (line.startsWith('Username:')) {
          username = line.substring('Username:'.length).trim();
        } else if (line.startsWith('Password:')) {
          password = line.substring('Password:'.length).trim();
        }
      }
      if (username.isNotEmpty && password.isNotEmpty) {
        return {'username': username, 'password': password};
      }
    } catch (e) {
      print('❌ Error reading login info: $e');
    }
    return null;
  }

  static Future<void> clearLoginInfo() async {
    try {
      final file = await _getLocalFile();
      await file.writeAsString('');
      print('🧹 Login info cleared');
    } catch (e) {
      print('❌ Error clearing login info: $e');
    }
  }
}
