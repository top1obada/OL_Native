import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_payment_details_dto.dart';

class WDCasePaymentsDetails extends StatelessWidget {
  const WDCasePaymentsDetails({super.key, required this.casePaymentDetailsDTO});

  final ClsCasePaymentDetailsDTO casePaymentDetailsDTO;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const Icon(Icons.payment, color: Colors.blue),
          title: Text(
            "Payment ID: ${casePaymentDetailsDTO.paymentID ?? 'N/A'}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Amount: ${casePaymentDetailsDTO.paymentAmount?.toStringAsFixed(2) ?? '0.00'}",
                style: TextStyle(color: Colors.green[800]),
              ),
              Text(
                "Method: ${casePaymentDetailsDTO.paymentMethod ?? 'Unknown'}",
                style: TextStyle(color: Colors.blueGrey[700]),
              ),
              Text(
                "Details: ${casePaymentDetailsDTO.paymentDetails ?? '-'}",
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
          trailing: Text(
            casePaymentDetailsDTO.paymentDate != null
                ? casePaymentDetailsDTO.paymentDate!.toLocal().toString().split(
                  ' ',
                )[0]
                : 'No Date',
            style: TextStyle(color: Colors.grey[700]),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
