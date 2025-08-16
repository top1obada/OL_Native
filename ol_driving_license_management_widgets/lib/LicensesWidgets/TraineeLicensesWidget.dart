import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/LicensesDTOs/TraineeLicenseDTO.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/show_cases_widget.dart';
import 'package:ol_driving_license_management_widgets/LicensesWidgets/TraineeLicenseWidget.dart';

class WDShowTraineeLiceses extends StatelessWidget {
  const WDShowTraineeLiceses({
    super.key,
    required this.traineeLicenses,
    this.onTab,
  });

  final List<ClsTraineeLicenseDTO> traineeLicenses;

  final IntCallBack? onTab;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder:
          (context, index) => WDTraineeLicenseDetails(
            traineeLicenseDTO: traineeLicenses[index],
            onTap: onTab,
          ),
      itemCount: traineeLicenses.length,
    );
  }
}
