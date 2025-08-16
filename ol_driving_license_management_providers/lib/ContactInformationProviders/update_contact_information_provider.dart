import 'package:flutter/cupertino.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';
import 'package:ol_driving_license_management_connect_api/ContactInformationConnect/update_contact_information_connect.dart';
import 'package:ol_driving_license_management_connect_api/ContactInformationConnect/find_contact_information_connect.dart';

class PVUpdateContactInformation with ChangeNotifier {
  ClsContactInformationDTO? _contactInformationDTO;

  ClsContactInformationDTO? get contactInformationDTO => _contactInformationDTO;

  void loadContactInformation(ClsContactInformationDTO contactinformation) {
    _contactInformationDTO = contactinformation;
  }

  void clear() {
    _contactInformationDTO = null;
  }

  Future<void> fetch({required int contactID}) async {
    _contactInformationDTO = await ContactInformationConnect.find(contactID);
    notifyListeners();
  }

  Future<UpdateContactInformationResult> save() async {
    if (_contactInformationDTO == null) {
      return UpdateContactInformationResult(
        success: false,
        error: "No contact information provided.",
      );
    }

    final result =
        await UpdateContactInformationConnect.updateContactInformation(
          _contactInformationDTO!,
        );

    if (result.success) {
      notifyListeners();
    }

    return result;
  }
}
