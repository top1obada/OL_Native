import 'package:flutter/material.dart';

import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/build_info_row.dart';

class WDShowNativePerson extends StatelessWidget {
  const WDShowNativePerson({super.key, this.nativePersonDTO});

  final ClsNativePersonDTO? nativePersonDTO;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double widthFactor;
    if (screenWidth < 600) {
      widthFactor = 0.9; // موبايل
    } else if (screenWidth < 1000) {
      widthFactor = 0.7; // تابلت
    } else {
      widthFactor = 0.4; // شاشات أكبر
    }

    String? formatDate(DateTime? dt) {
      if (dt == null) return null;
      return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
    }

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Card(
        color: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Person Information",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                nativePersonDTO == null
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
                          label: "Person ID:",
                          value: nativePersonDTO?.personID?.toString(),
                        ),
                        BuildInfoRow(
                          label: "National Number:",
                          value: nativePersonDTO?.nationalNumber,
                        ),
                        BuildInfoRow(
                          label: "First Name:",
                          value: nativePersonDTO?.firstName,
                        ),
                        BuildInfoRow(
                          label: "Second Name:",
                          value: nativePersonDTO?.secondName,
                        ),
                        BuildInfoRow(
                          label: "Last Name:",
                          value: nativePersonDTO?.lastName,
                        ),

                        BuildInfoRow(
                          label: "Birthday:",
                          value: formatDate(nativePersonDTO?.birthday),
                        ),
                        BuildInfoRow(
                          label: "Gender:",
                          value: nativePersonDTO?.gender,
                        ),
                        BuildInfoRow(
                          label: "Nationality ID:",
                          value: nativePersonDTO?.nationalityID?.toString(),
                        ),
                        BuildInfoRow(
                          label: "Nationality Name:",
                          value: nativePersonDTO?.nationalityName,
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
