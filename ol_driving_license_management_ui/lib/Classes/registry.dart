import 'dart:io';

class FileUtils {
  static File _getLocalFile() {
    // Create file inside the project path
    return File('LoginInfoData.txt');
  }

  static Future<void> saveLoginInfo(String username, String password) async {
    try {
      final file = _getLocalFile();

      // Create the file if it doesn't exist (regardless of content)
      if (!await file.exists()) {
        await file.create(recursive: true);
        print('Login info file created: ${file.absolute.path}');
      }

      // Check if file already contains login info
      final existingContent = await file.readAsString();

      // Check if the file already contains username and password
      final hasUsername = existingContent.contains('Username:');
      final hasPassword = existingContent.contains('Password:');

      if (hasUsername && hasPassword) {
        print('Login info already exists in file. Skipping save operation.');
        return; // Exit without saving
      }

      // If file doesn't contain login info, proceed with save
      final content = 'Username:$username\nPassword:$password';
      await file.writeAsString(content);
      print('Login info saved successfully to: ${file.absolute.path}');
    } catch (e) {
      print('Error saving login info: $e');
    }
  }

  static Future<Map<String, String>?> readLoginInfo() async {
    try {
      final file = _getLocalFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        final lines = content.split('\n');

        // Add validation to prevent index errors
        if (lines.length >= 2) {
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
        }
      }
    } catch (e) {
      print('Error reading login info: $e');
    }
    return null;
  }

  static Future<void> clearLoginInfo() async {
    try {
      final file = _getLocalFile();
      if (await file.exists()) {
        // Clear the file content instead of deleting the file
        await file.writeAsString('');
        print('Login info content cleared successfully');
      }
    } catch (e) {
      print('Error clearing login info: $e');
    }
  }
}
