import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/CaseConnect/case_retriving_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';

class PVRetrivingCases extends ChangeNotifier {
  List<ClsCaseDTO>? casesList;

  Future<void> getCasesByTraineeID(int? traineeID) async {
    if (traineeID == null) {
      casesList = [];
      notifyListeners();
      return;
    }
    casesList = await CaseConnect.getCases(traineeID);
    notifyListeners();
  }
}
