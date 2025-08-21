import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileUtils {
  static String? nativePath;

  static Future<void> _fillNativePath() async {
    if (nativePath == null) {
      final dir = await getApplicationDocumentsDirectory();
      nativePath = p.join(dir.path, "login_info.txt"); // ✅ cross-platform
    }
  }

  static Future<void> save(String username, String password) async {
    await _fillNativePath();
    final file = File(nativePath!);

    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.contains("Username:$username") &&
          content.contains("Password:$password")) {
        print("ℹ️ نفس البيانات موجودة مسبقاً، لن يتم الحفظ");
        return;
      }
    }

    await file.writeAsString("Username:$username\nPassword:$password");
    print("✅ تم حفظ البيانات بنجاح");
  }

  static Future<Map<String, String>?> read() async {
    await _fillNativePath();
    final file = File(nativePath!);
    if (await file.exists()) {
      final lines = await file.readAsLines();
      String username = '';
      String password = '';
      for (var line in lines) {
        if (line.startsWith("Username:")) {
          username = line.replaceFirst("Username:", "").trim();
        } else if (line.startsWith("Password:")) {
          password = line.replaceFirst("Password:", "").trim();
        }
      }
      if (username.isNotEmpty && password.isNotEmpty) {
        return {"username": username, "password": password};
      }
    }
    return null;
  }

  static Future<void> clear() async {
    await _fillNativePath();
    final file = File(nativePath!);
    if (await file.exists()) {
      await file.writeAsString('');
      print("🧹 تم مسح البيانات");
    }
  }
}
