import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_payment_details_dto.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/CasePaymentsWidgets/case_payments_details_widget.dart';

class WDShowCasePaymentsDetails extends StatelessWidget {
  const WDShowCasePaymentsDetails({
    super.key,
    required this.casePaymentsDetails,
  });

  final List<ClsCasePaymentDetailsDTO> casePaymentsDetails;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: casePaymentsDetails.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: WDCasePaymentsDetails(
            casePaymentDetailsDTO: casePaymentsDetails[index],
          ),
        );
      },
    );
  }
}
