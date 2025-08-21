import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/AppoitementProviders/appoitement_Provider.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/PaymentsProviders/cases_total_payments_provider.dart';
import 'package:ol_driving_license_management_providers/FilesProviders/vision_text_result_file_upload_provider.dart';
import 'package:ol_driving_license_management_providers/LicensesProviders/GetAllTraineeLicenseProvider.dart';
import 'package:ol_driving_license_management_providers/TraineeProviders/trainee_requests_provider.dart';
import 'package:ol_driving_license_management_ui/AppoitementUI/show_trainee_appoitements_ui.dart';
import 'package:ol_driving_license_management_ui/Classes/registry.dart';

import 'package:ol_driving_license_management_ui/LicensesUI/TraineeLicenseUI.dart';
import 'package:ol_driving_license_management_ui/LoginUI/login_screen_ui.dart';
import 'package:ol_driving_license_management_ui/PaymentsDetailsUI/CasePaymentsUI/show_cases_total_payments_ui.dart';
import 'package:ol_driving_license_management_ui/RequestsUI/requests_main_menu_ui.dart';
import 'package:ol_driving_license_management_ui/completed_person_ui/show_completed_person_ui.dart';
import 'package:ol_driving_license_management_ui/FilesUI/vision_test_result_upload_ui.dart';
import 'package:provider/provider.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var loggedInInfo = context.read<PVBaseCurrentLogin>();

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(70),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200.withAlpha(
                        (0.5 * 255).round(),
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.drive_eta,
                    size: 80,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),

              const Divider(),

              // Profile
              ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.blue),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => UIShowCompletedPerson(
                            personID:
                                loggedInInfo
                                    .currentLoginInformationDTO!
                                    .personID!,
                          ),
                    ),
                  );
                },
              ),

              // Requests
              ListTile(
                leading: const Icon(Icons.assignment, color: Colors.orange),
                title: const Text('Requests'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider.value(value: loggedInInfo),
                              ChangeNotifierProvider(
                                create: (con) => PVUserRequests(),
                              ),
                            ],
                            child: const UIRequestsMainMenu(),
                          ),
                    ),
                  );
                },
              ),

              // Licenses
              ListTile(
                leading: const Icon(Icons.card_membership, color: Colors.green),
                title: const Text('My Licenses'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (con) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider.value(value: loggedInInfo),
                              ChangeNotifierProvider(
                                create: (context) => PVTraineeLicenses(),
                              ),
                            ],
                            child: const UIShowTraineeLicensesDetails(),
                          ),
                    ),
                  );
                },
              ),

              // Book Test
              ListTile(
                leading: const Icon(Icons.add_circle, color: Colors.purple),
                title: const Text('Book a Test'),
                onTap: () {},
              ),

              // Appointments
              ListTile(
                leading: const Icon(Icons.event_available, color: Colors.teal),
                title: const Text('My Appointments'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (con) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                create: (c) => PVTraineeAppoitements(),
                              ),
                              ChangeNotifierProvider.value(value: loggedInInfo),
                            ],
                            child: UIShowTraineeAppoitements(),
                          ),
                    ),
                  );
                },
              ),

              // Payments
              ListTile(
                leading: const Icon(Icons.payment, color: Colors.indigo),
                title: const Text('Payments'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (con) {
                        return MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(value: loggedInInfo),
                            ChangeNotifierProvider(
                              create: (context) => PVCasesTotalPayment(),
                            ),
                          ],
                          child: UIShowCasesTotalPayments(
                            traineeID:
                                loggedInInfo
                                    .currentLoginInformationDTO!
                                    .traineeID,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              // Vision Test Results - NEW ITEM
              ListTile(
                leading: const Icon(Icons.remove_red_eye, color: Colors.amber),
                title: const Text('Vision Test Results'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (con) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider.value(value: loggedInInfo),
                              ChangeNotifierProvider(
                                create: (con) => PVVisionTestResultFileUpload(),
                              ),
                            ],
                            child:
                                const UIUploadVisionTestResult(), // Make sure to create this UI component
                          ),
                    ),
                  );
                },
              ),

              const Divider(),

              // Settings
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.grey),
                title: const Text('Settings'),
                onTap: () {},
              ),

              // Help
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.blueGrey),
                title: const Text('Help & FAQ'),
                onTap: () {},
              ),

              // Logout
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text('Logout'),
                onTap: () async {
                  loggedInInfo.clear();

                  await FileUtils.clearLoginInfo();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder:
                          (con) => ChangeNotifierProvider(
                            create: (c) => PVLogin(),
                            child: LoginScreenUI(),
                          ),
                    ),
                    (Route<dynamic> rr) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
