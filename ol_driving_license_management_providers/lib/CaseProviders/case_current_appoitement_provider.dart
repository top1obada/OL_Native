import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/CaseConnect/case_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_current_appoitement_dto.dart';

class PVCaseCurrentAppoitementProvider extends ChangeNotifier {
  ClsCaseAppointmentDTO? caseCurrentAppoitementDTO;

  Future<void> getCaseCurrentappoitement(int caseID) async {
    caseCurrentAppoitementDTO =
        await CaseAppointmentConnect.getCurrentAppointment(caseID);
    notifyListeners();
  }
}
