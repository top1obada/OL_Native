import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart'; // تأكد من مسار الاستيراد الصحيح
import 'package:ol_driving_license_management_widgets/SomeWidgets/build_info_row.dart';

class WDShowAddress extends StatelessWidget {
  const WDShowAddress({super.key, this.addressDTO});

  final ClsAddressDTO? addressDTO;

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
                    "Address Information",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                addressDTO == null
                    ? const Center(
                      child: Text(
                        "No Address Found",
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
                          label: "Country:",
                          value: addressDTO?.countryName,
                        ),
                        BuildInfoRow(label: "City:", value: addressDTO?.city),
                        BuildInfoRow(label: "Town:", value: addressDTO?.town),
                        BuildInfoRow(
                          label: "Street:",
                          value: addressDTO?.street,
                        ),
                        BuildInfoRow(
                          label: "Building Name:",
                          value: addressDTO?.buldingName,
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
