import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';

import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/show_cases_widget.dart';
import 'package:provider/provider.dart';

class UIShowCasesDetails extends StatefulWidget {
  const UIShowCasesDetails({super.key, required this.traineeID, this.onTab});

  final int? traineeID;

  final Function(ClsCaseDTO?)? onTab;

  @override
  State<UIShowCasesDetails> createState() => _UIShowCasesDetailsState();
}

class _UIShowCasesDetailsState extends State<UIShowCasesDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pvCases = context.read<PVRetrivingCases>();
      await pvCases.getCasesByTraineeID(widget.traineeID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Cases',
      body: Consumer<PVRetrivingCases>(
        builder: (context, pvCases, child) {
          if (pvCases.casesList == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (pvCases.casesList!.isEmpty) {
            return Center(
              child: Text(
                "No Result Found, You Cant Create Test Request Before Creating License Case !",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: WDShowCasesDetails(
              casesList: pvCases.casesList!,
              onTab: (C) => widget.onTab?.call(C),
            ),
          );
        },
      ),
    );
  }
}
