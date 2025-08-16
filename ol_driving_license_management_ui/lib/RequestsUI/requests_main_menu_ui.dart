import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';
import 'package:ol_driving_license_management_providers/LicensesProviders/FindTraineeLicenseProvider.dart';
import 'package:ol_driving_license_management_providers/LicensesProviders/GetAllTraineeLicenseProvider.dart';
import 'package:ol_driving_license_management_providers/RequestsProviders/InternationalDrivingLicenseRequestProviders/CreateInternationalDrivingLicenseRequestProvider.dart';
import 'package:ol_driving_license_management_providers/RequestsProviders/TestRequestProviders/CreateTestRequestProvider.dart';
import 'package:ol_driving_license_management_ui/CaseUI/show_cases_ui.dart';
import 'package:ol_driving_license_management_ui/InternationalDrivingLicenseRequestUI/InternationalDrivingLicenseRequestUI.dart';
import 'package:ol_driving_license_management_ui/LicensesUI/TraineeLicenseUI.dart';
import 'package:ol_driving_license_management_ui/RequestsUI/DrivingLicenseRequestsUI/new_driving_license_request_ui.dart';
import 'package:ol_driving_license_management_ui/TestRequestUI/TestRequestUI.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/TraineeWidgets/trainee_request_widget.dart';
import 'package:provider/provider.dart';
import 'package:ol_driving_license_management_providers/TraineeProviders/trainee_requests_provider.dart';

class UIRequestsMainMenu extends StatefulWidget {
  const UIRequestsMainMenu({super.key});

  @override
  State<UIRequestsMainMenu> createState() {
    return _UIRequestsMainMenu();
  }
}

class _UIRequestsMainMenu extends State<UIRequestsMainMenu> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<PVUserRequests>().loadUserRequests(
        context.read<PVBaseCurrentLogin>().currentLoginInformationDTO!.userID!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentbase = context.read<PVBaseCurrentLogin>();

    return BaseScaffold(
      title: 'Requests',
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.blue.shade100,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.blueAccent),
              ),
              child: ExpansionTile(
                title: Text(
                  'Driving Licenses Requests',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_down),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ChangeNotifierProvider.value(
                                        value: currentbase,
                                        child:
                                            const UINewDrivingLicenseRequest(),
                                      ),
                                ),
                              );
                            },
                            child: const Text('New Driving License Request'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider.value(
                                            value: currentbase,
                                          ),
                                          ChangeNotifierProvider(
                                            create:
                                                (context) =>
                                                    PVTraineeLicenses(),
                                          ),
                                        ],
                                        child: UIShowTraineeLicensesDetails(
                                          onTab: (licenseID) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => MultiProvider(
                                                      providers: [
                                                        ChangeNotifierProvider.value(
                                                          value: currentbase,
                                                        ),
                                                        ChangeNotifierProvider(
                                                          create:
                                                              (context) =>
                                                                  PVFindTraineeLicense(),
                                                        ),
                                                        ChangeNotifierProvider(
                                                          create:
                                                              (context) =>
                                                                  PVCreateInternationalDrivingLicenseRequest(),
                                                        ),
                                                      ],
                                                      child:
                                                          UIInternationalDrivingLicenseRequest(
                                                            licenseID:
                                                                licenseID,
                                                          ),
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: const Text(
                              'International Driving License Request',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // === Second Card ===
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.blue.shade100,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.green),
              ),
              child: ExpansionTile(
                title: Text(
                  'Tests Requests',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_down),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (con) => MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider.value(
                                            value: currentbase,
                                          ),
                                          ChangeNotifierProvider(
                                            create:
                                                (context) => PVRetrivingCases(),
                                          ),
                                        ],
                                        child: UIShowCasesDetails(
                                          traineeID:
                                              currentbase
                                                  .currentLoginInformationDTO!
                                                  .traineeID!,
                                          onTab:
                                              (c) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (
                                                        context,
                                                      ) => MultiProvider(
                                                        providers: [
                                                          ChangeNotifierProvider(
                                                            create:
                                                                (context) =>
                                                                    PVTestRequestProvider(),
                                                          ),
                                                          ChangeNotifierProvider.value(
                                                            value: currentbase,
                                                          ),
                                                        ],
                                                        child: UITestRequest(
                                                          caseDTO: c,
                                                          testTypeID: 1,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: const Text('Theory Test Request'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (con) => MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider.value(
                                            value: currentbase,
                                          ),
                                          ChangeNotifierProvider(
                                            create:
                                                (context) => PVRetrivingCases(),
                                          ),
                                        ],
                                        child: UIShowCasesDetails(
                                          traineeID:
                                              currentbase
                                                  .currentLoginInformationDTO!
                                                  .traineeID!,
                                          onTab:
                                              (c) => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (
                                                        context,
                                                      ) => MultiProvider(
                                                        providers: [
                                                          ChangeNotifierProvider(
                                                            create:
                                                                (context) =>
                                                                    PVTestRequestProvider(),
                                                          ),
                                                          ChangeNotifierProvider.value(
                                                            value: currentbase,
                                                          ),
                                                        ],
                                                        child: UITestRequest(
                                                          caseDTO: c,
                                                          testTypeID: 2,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: const Text('Practical Test Request'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Consumer<PVUserRequests>(
            builder: (context, value, child) {
              if (value.userRequests == null) {
                return const CircularProgressIndicator();
              }

              if (value.userRequests!.isEmpty) {
                return Text(
                  "There Is No Requests",
                  style: TextStyle(fontSize: 12),
                );
              }

              return ListView.builder(
                shrinkWrap: true, // Add this
                physics:
                    const NeverScrollableScrollPhysics(), // Add this to prevent nested scrolling
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(
                        6,
                      ), // Fixed EdgeInsetsGeometry to EdgeInsets
                      child: WDUserRequestDetails(
                        requestDTO: value.userRequests![index],
                      ),
                    ),
                itemCount: value.userRequests!.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
