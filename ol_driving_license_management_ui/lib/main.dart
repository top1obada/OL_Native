import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/SecureStorage/secore_storage.dart';

import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';

import 'package:ol_driving_license_management_ui/LoginUI/login_screen_ui.dart';
import 'package:ol_driving_license_management_ui/MainUI/main_screen_ui.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final loginData = await StorageService.read();

    if (loginData == null) {
      runApp(
        ChangeNotifierProvider(create: (c) => PVLogin(), child: const MyApp()),
      );
      return;
    }

    PVLogin pvLogin = PVLogin();

    var result = await pvLogin.login(
      ClsLoginDataDTO(
        userName: loginData['username']!,
        password: loginData['password']!,
      ),
    );

    if (result) {
      PVBaseCurrentLogin currentLogin = pvLogin;
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: currentLogin),
            ChangeNotifierProvider(create: (_) => PVRetrivingCases()),
          ],
          child: const MainScreen(),
        ),
      );
      return;
    }

    runApp(
      ChangeNotifierProvider(create: (c) => PVLogin(), child: const MyApp()),
    );

    return;
  } catch (er) {
    runApp(MaterialApp(home: const Error()));
  }
}

class Error extends StatelessWidget {
  const Error({super.key, this.e});

  final String? e;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center(child: Text("Faild"))));
  }
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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OL Driving License Management",
      home: const UIMainScreen(),
    );
  }
}
