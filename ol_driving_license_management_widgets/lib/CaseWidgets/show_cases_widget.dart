import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/case_widget.dart';

typedef IntCallBack = void Function(int);

class WDShowCasesDetails extends StatelessWidget {
  const WDShowCasesDetails({super.key, required this.casesList, this.onTab});

  final List<ClsCaseDTO> casesList;

  final Function(ClsCaseDTO?)? onTab;

  @override
  Widget build(BuildContext context) {
    if (casesList.isEmpty) {
      return Center(
        child: Text(
          "No Result Found",
          style: TextStyle(
            fontSize: 16, // Larger font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.grey[600], // Subtle gray color
            fontStyle: FontStyle.normal, // Optional italic style
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: casesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: WDCaseDetails(caseDTO: casesList[index], onTab: onTab),
        );
      },
    );
  }
}
