import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/CaseConnect/CasePaymentsConnect/case_payments_details_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_payment_details_dto.dart';

class PVCasePaymentDetails extends ChangeNotifier {
  List<ClsCasePaymentDetailsDTO>? casesPaymentDetails;

  Future<void> getCasesPaymentDetails(int caseID) async {
    casesPaymentDetails = await CasePaymentsDetailsConnect.getPaymentsByCaseID(
      caseID,
    );

    notifyListeners();
  }
}
