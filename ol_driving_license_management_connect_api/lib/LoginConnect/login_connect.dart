import 'dart:convert';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';

class LoginConnect {
  LoginConnect._();

  static Future<String?> login(ClsLoginDataDTO loginData) async {
    try {
      final String loginDataJson = jsonEncode(loginData.toJson());
      DioClient.setLoginData(loginDataJson);

      final response = await DioClient.dio.get('Login');

      final String token = response.data.toString();

      if (token.isNotEmpty) {
        DioClient.setAuthToken(token);
        return token;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
