import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/LoginConnect/login_connect.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_connect_api/SignUpConnect/sign_up_connect.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/current_login_information.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_dto/SignUpDTOs/sign_up_dto.dart';
import 'package:ol_driving_license_management_providers/StaticLibraries/token_library.dart';

class PVBaseCurrentLogin extends ChangeNotifier {
  ClsCurrentLoginInformationDTO? _currentLoginInformationDTO;

  ClsCurrentLoginInformationDTO? get currentLoginInformationDTO =>
      _currentLoginInformationDTO;

  PVBaseCurrentLogin() {
    _currentLoginInformationDTO = ClsCurrentLoginInformationDTO();
  }
}

class PVLogin extends PVBaseCurrentLogin {
  PVLogin() : super();

  Future<bool> login(ClsLoginDataDTO loginData) async {
    String? token = await LoginConnect.login(loginData);

    _currentLoginInformationDTO = TokenLibrary.extractLoginInfoFromToken(token);

    if (token != null) {
      notifyListeners();
      return true;
    }

    return false;
  }

  void clear() {
    _currentLoginInformationDTO = null;
    DioClient.clearHeaders();
    notifyListeners();
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

      notifyListeners();
      return true;
    }

    return false;
  }

  void clear() {
    _currentLoginInformationDTO = null;
    DioClient.clearHeaders();
    notifyListeners();
  }
}
