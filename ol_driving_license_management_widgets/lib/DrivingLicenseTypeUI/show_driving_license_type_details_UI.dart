import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/DrivingLicenseTypeDTO/driving_license_type_dto.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/wrap_row_building.dart';

class WDShowDrivingLicenseTypeInfoCard extends StatelessWidget {
  final ClsDrivingLicenseTypeDTO licenseTypeDTO;

  const WDShowDrivingLicenseTypeInfoCard({
    super.key,
    required this.licenseTypeDTO,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double baseFontSize =
        screenWidth < 400
            ? 14
            : screenWidth < 600
            ? 16
            : 20;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildRowWrap(
                label: 'License Type ID:',
                value: licenseTypeDTO.licenseTypeID?.toString() ?? 'N/A',
                fontSize: baseFontSize,
              ),
              BuildRowWrap(
                label: 'License Type Name:',
                value: licenseTypeDTO.licenseTypeName ?? 'N/A',
                fontSize: baseFontSize,
                valueColor: Colors.blue[800],
              ),
              BuildRowWrap(
                label: 'Total Cost:',
                value:
                    licenseTypeDTO.licenseTypeTotalCost != null
                        ? licenseTypeDTO.licenseTypeTotalCost!.toStringAsFixed(
                          2,
                        )
                        : '0.00',
                fontSize: baseFontSize,
              ),
              BuildRowWrap(
                label: 'Period (Months):',
                value: licenseTypeDTO.periodInMonths?.toString() ?? 'N/A',
                fontSize: baseFontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
