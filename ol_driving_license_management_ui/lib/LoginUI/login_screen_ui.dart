import 'package:flutter/material.dart';
import 'package:my_widgets/TextFormsFiledsWidgets/PasswordTextFormFileds/native_password_text_form_filed.dart';
import 'package:my_widgets/TextsFiledsFunctions/TextFileds.dart';
import 'package:my_widgets/Validators/vd_not_empty.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';
import 'package:ol_driving_license_management_ui/MainUI/main_screen_ui.dart';
import 'package:ol_driving_license_management_ui/SignUPUI/sign_up_ui.dart';
import 'package:provider/provider.dart';

class LoginScreenUI extends StatefulWidget {
  const LoginScreenUI({super.key});

  @override
  State<LoginScreenUI> createState() => _LoginScreenUIState();
}

class _LoginScreenUIState extends State<LoginScreenUI> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    var result = await context.read<PVLogin>().login(
      ClsLoginDataDTO(
        userName: usernameController.text,
        password: passwordController.text,
      ),
    );

    if (!mounted) return;

    if (result) {
      PVBaseCurrentLogin currentLogin = context.read<PVLogin>();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: currentLogin),
                  ChangeNotifierProvider(create: (con) => PVRetrivingCases()),
                ],
                child: const UIMainScreen(),
              ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username or Password is wrong'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OL DRIVING LICENCE MANAGEMENT',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Divider(color: Colors.grey),
            SizedBox(height: 20),

            // Mobile number field
            TextFields.buildInputField(
              'User Name',
              usernameController,
              validator:
                  (value) =>
                      EmptyValidator.validateNotEmpty(value, "User Name"),
            ),

            SizedBox(height: 20),

            // Password field
            WDNativePasswordTextFormField(controller: passwordController),

            SizedBox(height: 30),

            // ✅ Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _login();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text('Login'),
              ),
            ),

            SizedBox(height: 10),

            // Register link (can be replaced later with navigation)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (innerContext) => ChangeNotifierProvider(
                          create: (con) => PVSignUp(),
                          child: const UISignUp(),
                        ),
                  ),
                );
              },
              child: const Text('Not Registered Yet? Register Free!'),
            ),

            SizedBox(height: 20),

            Text('Or Login Using', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook, size: 30, color: Colors.blue[800]),
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.g_mobiledata, size: 30, color: Colors.red),
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.apple, size: 30, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
