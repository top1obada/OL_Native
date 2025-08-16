import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/TestConnect/TestConnect.dart';
import 'package:ol_driving_license_management_dto/TestDTO/CaseTestDTO.dart';

class PVIsCasePassTheoryTest extends ChangeNotifier {
  bool? result;

  Future<void> isCasePassTest(ClsCaseTestDTO caseTestDTO) async {
    caseTestDTO.testTypeID = 1;
    result = await TestConnect.didUserPassTest(caseTestDTO);

    notifyListeners();
  }
}

class PVIsCasePassPracticalTest extends ChangeNotifier {
  bool? result;

  Future<void> isCasePassTest(ClsCaseTestDTO caseTestDTO) async {
    result = await TestConnect.didUserPassTest(caseTestDTO);

    notifyListeners();
  }
}
