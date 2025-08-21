import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/SecureStorage/secore_storage.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/case_current_appoitement_provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';
import 'package:ol_driving_license_management_providers/TestProviders/IsCasePassTestProvider.dart';
import 'package:ol_driving_license_management_ui/CaseUI/show_case_details.dart';

import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/AccountCardWidgets/account_card_widget.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/case_widget.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/show_cases_widget.dart';

import 'package:provider/provider.dart';

class UIMainScreen extends StatefulWidget {
  const UIMainScreen({super.key});

  @override
  State<UIMainScreen> createState() {
    return _UIMainScreen();
  }
}

class _UIMainScreen extends State<UIMainScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pro = context.read<PVRetrivingCases>();

      await pro.getCasesByTraineeID(
        context
            .read<PVBaseCurrentLogin>()
            .currentLoginInformationDTO!
            .traineeID,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentLoggedIn = context.read<PVBaseCurrentLogin>();

    return BaseScaffold(
      title: 'Main screen',

      body: ListView(
        children: [
          Center(child: Text("${FileUtils.nativePath}")),
          const SizedBox(height: 10),
          WDAccountCard(
            firstName: currentLoggedIn.currentLoginInformationDTO!.firstName!,
            userId: currentLoggedIn.currentLoginInformationDTO!.userID!,
            isActive:
                currentLoggedIn.currentLoginInformationDTO!.traineeID != null,
            profileImage: null,
          ),
          Consumer<PVRetrivingCases>(
            builder: (context, value, child) {
              if (value.casesList == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (value.casesList!.isEmpty) {
                return Center(
                  child: Text(
                    "No Opened Cases For Now",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }

              return Column(
                children:
                    value.casesList!
                        .map(
                          (caseDTO) => Padding(
                            padding: const EdgeInsets.all(6),
                            child: WDCaseDetails(
                              caseDTO: caseDTO,
                              onTab: (c) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (con) {
                                      return MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider(
                                            create:
                                                (c) => PVIsCasePassTheoryTest(),
                                          ),
                                          ChangeNotifierProvider(
                                            create:
                                                (c) =>
                                                    PVIsCasePassPracticalTest(),
                                          ),
                                          ChangeNotifierProvider.value(
                                            value: currentLoggedIn,
                                          ),
                                          ChangeNotifierProvider(
                                            create:
                                                (con) =>
                                                    PVCaseCurrentAppoitementProvider(),
                                          ),
                                        ],
                                        child: CaseTestStatusWidget(caseDTO: c),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                        .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
