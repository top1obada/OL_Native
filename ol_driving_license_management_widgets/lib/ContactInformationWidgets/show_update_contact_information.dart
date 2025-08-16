import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/build_text_form_filed.dart';
import 'package:ol_driving_license_management_widgets/WidgetsLibraries/sizing_widgets.dart';

class WDShowUpdateContactInformation extends StatelessWidget {
  const WDShowUpdateContactInformation({super.key, this.contactInformationDTO});

  final ClsContactInformationDTO? contactInformationDTO;

  @override
  Widget build(BuildContext context) {
    final isEnabled = contactInformationDTO != null;

    return FractionallySizedBox(
      widthFactor: SizingWidgets.getPecentSuitableWidgetWidth(context),
      child: Card(
        color: Colors.grey[850], // رمادي غامق مريح للعين
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Contact Informations',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                BuildTextFormFiled(
                  label: 'Phone Number',
                  initialValue: contactInformationDTO?.phoneNumber ?? '',
                  enabled: isEnabled,
                  onChanged: (val) {
                    if (contactInformationDTO != null) {
                      contactInformationDTO!.phoneNumber = val;
                    }
                  },
                ),
                const SizedBox(height: 8),
                BuildTextFormFiled(
                  label: 'Email',
                  initialValue: contactInformationDTO?.email ?? '',
                  enabled: isEnabled,
                  onChanged: (val) {
                    if (contactInformationDTO != null) {
                      contactInformationDTO!.email = val;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
