import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/CaseConnect/CasePaymentsConnect/cases_total_payments_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_total_payments_dto.dart';

class PVCasesTotalPayment extends ChangeNotifier {
  List<ClsCaseTotalPaymentsDTO>? casesTotalPayments;

  Future<void> getCasesTotalPayments(int traineeID) async {
    casesTotalPayments = await CaseTotalPaymentsConnect.getCasesByTraineeID(
      traineeID,
    );

    notifyListeners();
  }
}
