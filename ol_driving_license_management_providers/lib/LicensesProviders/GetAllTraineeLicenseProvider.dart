import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/Licenses/LicenseConnect.dart';
import 'package:ol_driving_license_management_dto/LicensesDTOs/TraineeLicenseDTO.dart';

class PVTraineeLicenses extends ChangeNotifier {
  List<ClsTraineeLicenseDTO>? traineeLicenses;

  Future<void> getTraineeLicenses(int? traineeID) async {
    if (traineeID == null) {
      traineeLicenses = [];
      notifyListeners();
      return;
    }
    traineeLicenses = await LicensesConnect.getLicenses(traineeID!);

    notifyListeners();
  }
}
