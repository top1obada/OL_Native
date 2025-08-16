import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';
import 'package:ol_driving_license_management_providers/ContactInformationProviders/update_contact_information_provider.dart';
import 'package:ol_driving_license_management_ui/ContactInformationUI/show_update_contact_information_ui.dart';
import 'package:ol_driving_license_management_widgets/ContactInformationWidgets/show_contact_information.dart';
import 'package:provider/provider.dart';

class UIShowContactInfo extends StatelessWidget {
  const UIShowContactInfo({super.key, this.contactInformationDTO});

  final ClsContactInformationDTO? contactInformationDTO;

  @override
  Widget build(BuildContext context) {
    if (contactInformationDTO == null ||
        contactInformationDTO!.contactID == null) {
      return WDShowContactInformation(contactInformationDTO: null);
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: ChangeNotifierProvider(
          create: (_) => PVUpdateContactInformation(),
          child: Builder(
            builder: (innerContext) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<PVUpdateContactInformation>(
                  builder: (context, value, child) {
                    if (value.contactInformationDTO != null) {
                      contactInformationDTO!.email =
                          value.contactInformationDTO!.email;
                      contactInformationDTO!.phoneNumber =
                          value.contactInformationDTO!.phoneNumber;
                    }
                    return WDShowContactInformation(
                      contactInformationDTO: contactInformationDTO,
                    );
                  },
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final provider = innerContext
                          .read<PVUpdateContactInformation>();

                      Navigator.push(
                        innerContext,
                        MaterialPageRoute(
                          builder: (innerContext) =>
                              ChangeNotifierProvider.value(
                                value: provider,
                                child: ShowUpdateContactInformationUI(
                                  contactID: contactInformationDTO!.contactID!,
                                ),
                              ),
                        ),
                      );

                      provider.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
