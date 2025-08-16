import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/CaseConnect/CasePaymentsConnect/case_payments_details_connect.dart';
import 'package:ol_driving_license_management_connect_api/Licenses/LicenseConnect.dart';
import 'package:ol_driving_license_management_dto/LicensesDTOs/TraineeLicenseDTO.dart';

class PVFindTraineeLicense extends ChangeNotifier {
  ClsTraineeLicenseDTO? traineeLicense;

  Future<void> findTraineeLicense(int licenseID) async {
    traineeLicense = await LicensesConnect.findByLicenseID(licenseID);
    notifyListeners();
  }
}
