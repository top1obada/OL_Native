import 'dart:convert';
import 'package:ol_driving_license_management_dto/SignUpDTOs/sign_up_dto.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';

class SignUpConnect {
  SignUpConnect._();

  static Future<String?> signUp(ClsSignUpDTO signUpData) async {
    final String loginJson = jsonEncode(signUpData.login?.toJson());
    DioClient.setLoginData(loginJson);

    final String personJson = jsonEncode(signUpData.person?.toJson());

    try {
      final response = await DioClient.dio.post('SignUp', data: personJson);

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
