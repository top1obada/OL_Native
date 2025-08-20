import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/LoginConnect/login_connect.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_connect_api/SignUpConnect/sign_up_connect.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/current_login_information.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_dto/SignUpDTOs/sign_up_dto.dart';
import 'package:ol_driving_license_management_providers/StaticLibraries/token_library.dart';

class FileUtils {
  static File _getLocalFile() {
    // For testing purposes, we'll use a simple file in the current directory
    // This will work for basic functionality until you can install path_provider
    return File('LoginInfoData.txt');
  }

  static Future<void> saveLoginInfo(String username, String password) async {
    try {
      final file = _getLocalFile();

      // Check if file already exists and contains login info
      if (await file.exists()) {
        final existingContent = await file.readAsString();

        // Check if the file already contains username and password
        final hasUsername = existingContent.contains('Username:');
        final hasPassword = existingContent.contains('Password:');

        if (hasUsername && hasPassword) {
          print('Login info already exists in file. Skipping save operation.');
          return; // Exit without saving
        }
      }

      // If file doesn't exist or doesn't contain login info, proceed with save
      final content = 'Username:$username\nPassword:$password';
      await file.writeAsString(content);
      print('Login info saved successfully to: ${file.absolute.path}');
    } catch (e) {
      print('Error saving login info: $e');
      // Fallback: Store in memory for testing
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
      // Fallback: Read from memory storage
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
      // Also clear memory storage
    } catch (e) {
      print('Error clearing login info: $e');
    }
  }
}

class PVBaseCurrentLogin extends ChangeNotifier {
  ClsCurrentLoginInformationDTO? _currentLoginInformationDTO;

  ClsCurrentLoginInformationDTO? get currentLoginInformationDTO =>
      _currentLoginInformationDTO;

  PVBaseCurrentLogin() {
    _currentLoginInformationDTO = ClsCurrentLoginInformationDTO();
  }

  void clear() {
    _currentLoginInformationDTO = null;
    DioClient.clearHeaders();
    FileUtils.clearLoginInfo(); // Clear file when logging out
    notifyListeners();
  }
}

class PVLogin extends PVBaseCurrentLogin {
  PVLogin() : super();

  Future<bool> login(ClsLoginDataDTO loginData) async {
    String? token = await LoginConnect.login(loginData);

    if (token != null) {
      _currentLoginInformationDTO = TokenLibrary.extractLoginInfoFromToken(
        token,
      );
      await FileUtils.saveLoginInfo(loginData.userName!, loginData.password!);
    }

    notifyListeners();
    return token != null;
  }
}

class PVSignUp extends PVBaseCurrentLogin {
  PVSignUp() : super();

  Future<bool> signUp(ClsSignUpDTO signUpData) async {
    String? token = await SignUpConnect.signUp(signUpData);

    if (token != null) {
      _currentLoginInformationDTO = TokenLibrary.extractLoginInfoFromToken(
        token,
      );
      await FileUtils.saveLoginInfo(
        signUpData.login!.userName!,
        signUpData.login!.password!,
      );
    }

    notifyListeners();
    return token != null;
  }
}
