import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import 'package:ol_driving_license_management_providers/CompletedPersonProviders/find_completed_person_provider.dart';
import 'package:ol_driving_license_management_ui/AddressUI/show_address_ui.dart';
import 'package:ol_driving_license_management_ui/ContactInformationUI/show_contact_information_ui.dart';
import 'package:ol_driving_license_management_ui/PersonUI/show_person_native_ui.dart';
import 'package:provider/provider.dart';

class UIShowCompletedPerson extends StatefulWidget {
  const UIShowCompletedPerson({super.key, required this.personID});
  final int personID;

  @override
  State<UIShowCompletedPerson> createState() => _UIShowCompletedPerson();
}

class _UIShowCompletedPerson extends State<UIShowCompletedPerson> {
  late PVFindCompletedPerson provider;

  @override
  void initState() {
    super.initState();
    provider = PVFindCompletedPerson();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.find(personID: widget.personID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person Profile')),
      body: ChangeNotifierProvider<PVFindCompletedPerson>.value(
        value: provider,
        child: Consumer<PVFindCompletedPerson>(
          builder: (context, value, child) {
            if (value.personDTO == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final person = value.personDTO!;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      UIShowNativePersonInfo(
                        nativePersonDTO: ClsNativePersonDTO(
                          personID: person.personID,
                          nationalNumber: person.nationalNumber,
                          firstName: person.firstName,
                          secondName: person.secondName,
                          lastName: person.lastName,
                          birthday: person.birthday,
                          gender: person.gender,
                          nationalityName: person.nationalityName,
                          contactID: person.contactInformation?.contactID,
                          addressID: person.address?.addressID,
                        ),
                      ),
                      const SizedBox(height: 16),
                      UIShowContactInfo(
                        contactInformationDTO: person.contactInformation,
                      ),
                      const SizedBox(height: 16),
                      UIShowAddress(addressDTO: person.address),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
