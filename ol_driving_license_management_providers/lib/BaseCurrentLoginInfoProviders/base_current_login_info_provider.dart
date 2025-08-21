import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/LoginConnect/login_connect.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_connect_api/SignUpConnect/sign_up_connect.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/current_login_information.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_dto/SignUpDTOs/sign_up_dto.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/SecureStorage/secore_storage.dart';
import 'package:ol_driving_license_management_providers/StaticLibraries/token_library.dart';

class PVBaseCurrentLogin extends ChangeNotifier {
  ClsCurrentLoginInformationDTO? _currentLoginInformationDTO;

  ClsCurrentLoginInformationDTO? get currentLoginInformationDTO =>
      _currentLoginInformationDTO;

  PVBaseCurrentLogin() {
    _currentLoginInformationDTO = ClsCurrentLoginInformationDTO();
  }

  void clear() async {
    _currentLoginInformationDTO = null;
    DioClient.clearHeaders();

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
    }

    notifyListeners();
    return token != null;
  }
}
