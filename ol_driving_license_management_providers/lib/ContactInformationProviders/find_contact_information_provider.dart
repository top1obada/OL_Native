import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/ContactInformationConnect/find_contact_information_connect.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';

class PVFindContactInformation extends ChangeNotifier {
  ClsContactInformationDTO? _contactInformationDTO;

  ClsContactInformationDTO? get contactInformationDTO => _contactInformationDTO;

  Future<void> find({required int contactID}) async {
    _contactInformationDTO = await ContactInformationConnect.find(contactID);
    notifyListeners();
  }
}
