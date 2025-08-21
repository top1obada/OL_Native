import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';

import 'package:ol_driving_license_management_dto/VisionTestRequestDTO/VisionTestResult.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';

import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';
import 'package:ol_driving_license_management_providers/FilesProviders/vision_text_result_file_upload_provider.dart';
import 'package:ol_driving_license_management_providers/LicensesProviders/GetAllTraineeLicenseProvider.dart';
import 'package:ol_driving_license_management_providers/RequestsProviders/TestRequestProviders/CreateTestRequestProvider.dart';
import 'package:ol_driving_license_management_ui/Classes/registry.dart';

import 'package:ol_driving_license_management_ui/LoginUI/login_screen_ui.dart';
import 'package:ol_driving_license_management_ui/MainUI/main_screen_ui.dart';

import 'package:provider/provider.dart';

void main() async {
  var result = await FileUtils.readLoginInfo();

  if (result != null) {
    var pv = PVLogin();

    var loginResult = await pv.login(
      ClsLoginDataDTO(
        userName: result['username'],
        password: result['password'],
      ),
    );

    if (loginResult) {
      PVBaseCurrentLogin baseCurrentLogin = pv;

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: baseCurrentLogin),
            ChangeNotifierProvider(create: (context) => PVRetrivingCases()),
          ],
          child: MaterialApp(
            title: 'OL Driving Licence Management',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const UIMainScreen(),
          ),
        ),
      );

      return;
    }
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => PVLogin())],
      child: const MyApp(),
    ),
  );

  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OL Driving Licence Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreenUI(),
    );
  }
}
