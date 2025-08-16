import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/CaseConnect/case_retriving_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';

class PVFindCase extends ChangeNotifier {
  ClsCaseDTO? caseDTO;

  Future<void> getCase(int caseID) async {
    caseDTO = await CaseConnect.findCase(caseID);
    notifyListeners();
  }
}
