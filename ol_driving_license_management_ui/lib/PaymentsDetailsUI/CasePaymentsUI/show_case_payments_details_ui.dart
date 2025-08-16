import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_total_payments_dto.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/PaymentsProviders/case_payments_details_provider.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/CasePaymentsWidgets/case_total_payments_widget.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/CasePaymentsWidgets/show_case_payments_deatils_widget.dart';
import 'package:provider/provider.dart';

class UIShowCasePaymentsDetails extends StatefulWidget {
  const UIShowCasePaymentsDetails({
    super.key,
    required this.caseTotalPaymentsDTO,
  });

  final ClsCaseTotalPaymentsDTO caseTotalPaymentsDTO;

  @override
  State<UIShowCasePaymentsDetails> createState() =>
      _UIShowCasePaymentsDetails();
}

class _UIShowCasePaymentsDetails extends State<UIShowCasePaymentsDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pvCasePaymentsDetails = context.read<PVCasePaymentDetails>();

      await pvCasePaymentsDetails.getCasesPaymentDetails(
        widget.caseTotalPaymentsDTO.caseID!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Case Payments Details",
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: WDCaseTotalPayment(
                caseTotalPaymentsDTO: widget.caseTotalPaymentsDTO,
              ),
            ),

            Consumer<PVCasePaymentDetails>(
              builder: (context, pvCasePaymentsDetails, child) {
                if (pvCasePaymentsDetails.casesPaymentDetails == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Expanded(
                  child: WDShowCasePaymentsDetails(
                    casePaymentsDetails:
                        pvCasePaymentsDetails.casesPaymentDetails!,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
