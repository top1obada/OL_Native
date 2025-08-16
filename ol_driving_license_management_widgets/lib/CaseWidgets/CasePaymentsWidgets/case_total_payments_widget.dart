import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_total_payments_dto.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/CasePaymentsWidgets/show_cases_total_payments_widget.dart';

class WDCaseTotalPayment extends StatelessWidget {
  const WDCaseTotalPayment({
    super.key,
    required this.caseTotalPaymentsDTO,
    this.onTab,
  });

  final ClsCaseTotalPaymentsDTO caseTotalPaymentsDTO;

  final CaseTotalPaymentsCallBack? onTab;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      child: Padding(
        padding: EdgeInsets.all(3),
        child: ListTile(
          leading: const Icon(Icons.folder, color: Colors.blue),
          title: Text(
            caseTotalPaymentsDTO.caseName ?? 'No Case Name',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Payments: ${caseTotalPaymentsDTO.totalPayments ?? 0}",
                style: TextStyle(color: Colors.green[800]),
              ),
              Text(
                "Due: ${caseTotalPaymentsDTO.due ?? 0}",
                style: TextStyle(color: Colors.red[800]),
              ),
            ],
          ),
          trailing: Text(
            caseTotalPaymentsDTO.startDate != null
                ? caseTotalPaymentsDTO.startDate!.toLocal().toString().split(
                  ' ',
                )[0]
                : 'No Date',
            style: TextStyle(color: Colors.grey[700]),
          ),
          onTap: () {
            onTab?.call(caseTotalPaymentsDTO);
          },
        ),
      ),
    );
  }
}
