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
    runApp(MyApp(loginData: loginData));
  } catch (e) {
    runApp(MaterialApp(home: const Error()));
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center(child: Text("Faild"))));
  }
}

class MyApp extends StatelessWidget {
  final Map<String, String>? loginData;

  const MyApp({super.key, this.loginData});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PVLogin()),
        ChangeNotifierProvider(create: (_) => PVRetrivingCases()),
      ],
      child: MaterialApp(
        title: 'OL Driving Licence Management',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FutureBuilder<bool>(
          future: _tryAutoLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == true) {
              return const UIMainScreen();
            } else {
              return const LoginScreenUI();
            }
          },
        ),
      ),
    );
  }

  Future<bool> _tryAutoLogin() async {
    if (loginData == null) return false;
    PVLogin loginProvider = PVLogin();
    var result = await loginProvider.login(
      ClsLoginDataDTO(
        userName: loginData!['username']!,
        password: loginData!['password']!,
      ),
    );
    return result;
  }
}
