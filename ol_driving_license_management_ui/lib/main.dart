import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/SecureStorage/secore_storage.dart';

import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';

import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';

import 'package:ol_driving_license_management_ui/LoginUI/login_screen_ui.dart';
import 'package:ol_driving_license_management_ui/MainUI/main_screen_ui.dart';

import 'package:provider/provider.dart';

void main() async {
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
