import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_total_payments_dto.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/CasePaymentsWidgets/case_total_payments_widget.dart';

typedef CaseTotalPaymentsCallBack = void Function(ClsCaseTotalPaymentsDTO);

class WDShowCasesTotalPayments extends StatelessWidget {
  const WDShowCasesTotalPayments({
    super.key,
    required this.casesTotalPayments,
    this.onTab,
  });

  final List<ClsCaseTotalPaymentsDTO> casesTotalPayments;

  final CaseTotalPaymentsCallBack? onTab;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: casesTotalPayments.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: WDCaseTotalPayment(
            caseTotalPaymentsDTO: casesTotalPayments[index],
            onTab: onTab,
          ),
        );
      },
    );
  }
}
