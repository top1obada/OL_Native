import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/PaymentsProviders/case_payments_details_provider.dart';
import 'package:ol_driving_license_management_ui/PaymentsDetailsUI/CasePaymentsUI/show_case_payments_details_ui.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/PaymentsProviders/cases_total_payments_provider.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/CasePaymentsWidgets/show_cases_total_payments_widget.dart';

class UIShowCasesTotalPayments extends StatefulWidget {
  const UIShowCasesTotalPayments({super.key, required this.traineeID});

  final int traineeID;

  @override
  State<UIShowCasesTotalPayments> createState() => _UIShowCasesTotalPayments();
}

class _UIShowCasesTotalPayments extends State<UIShowCasesTotalPayments> {
  _UIShowCasesTotalPayments();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pvCasetotalPayments = context.read<PVCasesTotalPayment>();

      await pvCasetotalPayments.getCasesTotalPayments(widget.traineeID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Cases Payments',
      body: Consumer<PVCasesTotalPayment>(
        builder: (context, pvCasesTotalPayments, child) {
          if (pvCasesTotalPayments.casesTotalPayments == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (pvCasesTotalPayments.casesTotalPayments!.isEmpty) {
            return Center(
              child: Text('No Result Found', style: TextStyle(fontSize: 16)),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: WDShowCasesTotalPayments(
              casesTotalPayments: pvCasesTotalPayments.casesTotalPayments!,
              onTab: (caseTotalPaymentsdto) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ChangeNotifierProvider(
                          create: (context) => PVCasePaymentDetails(),
                          child: UIShowCasePaymentsDetails(
                            caseTotalPaymentsDTO: caseTotalPaymentsdto,
                          ),
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
