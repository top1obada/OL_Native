import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/build_info_row.dart';
import 'package:ol_driving_license_management_widgets/WidgetsLibraries/sizing_widgets.dart';

class WDShowContactInformation extends StatelessWidget {
  const WDShowContactInformation({super.key, this.contactInformationDTO});

  final ClsContactInformationDTO? contactInformationDTO;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: SizingWidgets.getPecentSuitableWidgetWidth(context),
      child: Card(
        color: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(
            6,
          ), // ⬅️ Padding خارجي حول الـ Container
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(5), // ⬅️ Padding داخلي للمحتوى
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Contact Information",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                contactInformationDTO == null
                    ? const Center(
                      child: Text(
                        "No Result Found",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildInfoRow(
                          label: "Phone Number:",
                          value: contactInformationDTO?.phoneNumber,
                        ),
                        BuildInfoRow(
                          label: "Email:",
                          value: contactInformationDTO?.email,
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
