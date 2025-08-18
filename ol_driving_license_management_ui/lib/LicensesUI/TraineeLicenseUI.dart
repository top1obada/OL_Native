import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';

import 'package:ol_driving_license_management_providers/LicensesProviders/GetAllTraineeLicenseProvider.dart';

import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/show_cases_widget.dart';

import 'package:provider/provider.dart';

import 'package:ol_driving_license_management_widgets/LicensesWidgets/TraineeLicensesWidget.dart';

class UIShowTraineeLicensesDetails extends StatefulWidget {
  const UIShowTraineeLicensesDetails({super.key, this.onTab});

  final IntCallBack? onTab;

  @override
  State<UIShowTraineeLicensesDetails> createState() =>
      _UIShowTraineeLicensesDetailsState();
}

class _UIShowTraineeLicensesDetailsState
    extends State<UIShowTraineeLicensesDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pvTraineeLicenses = context.read<PVTraineeLicenses>();

      await pvTraineeLicenses.getTraineeLicenses(
        context
            .read<PVBaseCurrentLogin>()
            .currentLoginInformationDTO!
            .traineeID,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Trainee Licenses Details",
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<PVTraineeLicenses>(
          builder: (context, pvlicenses, child) {
            if (pvlicenses.traineeLicenses == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (pvlicenses.traineeLicenses!.isEmpty) {
              return Center(
                child: Text("No Result Found", style: TextStyle(fontSize: 16)),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: WDShowTraineeLiceses(
                traineeLicenses: pvlicenses.traineeLicenses!,
                onTab: (licenseID) {
                  widget.onTab?.call(licenseID);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
