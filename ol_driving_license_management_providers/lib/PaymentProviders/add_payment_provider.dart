import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/PaymentDTOs/payment_dto.dart';

import 'package:ol_driving_license_management_connect_api/PaymentConnect/payment_connect.dart';

class PVAddPayment extends ChangeNotifier {
  ClsPaymentDTO? payment;

  Future<void> insertPayment() async {
    if (payment == null) return;

    payment!.paymentID = await PaymentConnect.addPayment(payment!);

    notifyListeners();
  }
}
