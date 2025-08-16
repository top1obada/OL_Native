import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';
import 'package:ol_driving_license_management_dto/TestDTO/CaseTestDTO.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/case_current_appoitement_provider.dart';
import 'package:ol_driving_license_management_providers/TestProviders/IsCasePassTestProvider.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/case_current_appoitement_widget.dart';

import 'package:ol_driving_license_management_widgets/CaseWidgets/case_widget_card.dart';

import 'package:provider/provider.dart';

class CaseTestStatusWidget extends StatefulWidget {
  final ClsCaseDTO? caseDTO;

  const CaseTestStatusWidget({super.key, required this.caseDTO});

  @override
  State<CaseTestStatusWidget> createState() => _CaseTestStatusWidgetState();
}

class _CaseTestStatusWidgetState extends State<CaseTestStatusWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _checkTestStatus();
    });
  }

  Future<void> _checkTestStatus() async {
    await context.read<PVIsCasePassTheoryTest>().isCasePassTest(
      ClsCaseTestDTO(caseID: widget.caseDTO!.caseID, testTypeID: 1),
    );

    await context.read<PVIsCasePassPracticalTest>().isCasePassTest(
      ClsCaseTestDTO(caseID: widget.caseDTO!.caseID, testTypeID: 2),
    );

    await context
        .read<PVCaseCurrentAppoitementProvider>()
        .getCaseCurrentappoitement(widget.caseDTO!.caseID!);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Case Details',
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Case details card at the top
                WDCaseDetailsCard(caseDTO: widget.caseDTO!),

                const SizedBox(height: 20),

                // Test status section
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Theory test status
                    Consumer<PVIsCasePassTheoryTest>(
                      builder: (context, value, child) {
                        if (value.result == null) {
                          return CircularProgressIndicator();
                        }

                        if (value.result == true) {
                          return _TestStatusRow(
                            testType: 'Theory Test',
                            passed: value.result,
                          );
                        } else {
                          return _TestRequestButton(
                            testType: 'Theory',
                            testTypeID: 1,
                            caseDTO: widget.caseDTO!,
                            enabled: true,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Practical test status
                    Consumer<PVIsCasePassPracticalTest>(
                      builder: (con, value, child) {
                        if (value.result == null) {
                          return CircularProgressIndicator();
                        }

                        if (value.result == true) {
                          return _TestStatusRow(
                            testType: 'Practical Test',
                            passed: value.result,
                          );
                        } else {
                          return _TestRequestButton(
                            testType: 'Practical',
                            testTypeID: 2,
                            caseDTO: widget.caseDTO!,
                            enabled:
                                context.read<PVIsCasePassTheoryTest>().result ==
                                true,
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Consumer<PVCaseCurrentAppoitementProvider>(
                  builder: (context, value, child) {
                    if (value.caseCurrentAppoitementDTO != null) {
                      return WDCaseCurrentAppointment(
                        appointmentDTO: value.caseCurrentAppoitementDTO,
                      );
                    }
                    return Text(
                      "No Appoitement For This Case",
                      style: TextStyle(fontSize: 14),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TestStatusRow extends StatelessWidget {
  final String testType;
  final bool? passed;

  const _TestStatusRow({required this.testType, required this.passed});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;

    if (passed == null) {
      statusColor = Colors.grey;
      statusText = 'Unknown';
    } else if (passed!) {
      statusColor = Colors.green;
      statusText = 'Passed';
    } else {
      statusColor = Colors.orange;
      statusText = 'Not Passed';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          testType,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          statusText,
          style: TextStyle(
            fontSize: 16,
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _TestRequestButton extends StatelessWidget {
  final String testType;
  final int testTypeID;
  final ClsCaseDTO caseDTO;
  final bool enabled;

  const _TestRequestButton({
    required this.testType,
    required this.testTypeID,
    required this.caseDTO,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed:
              enabled
                  ? () {
                    // TODO: Implement test request functionality
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => TestRequestScreen(
                    //     caseDTO: caseDTO,
                    //     testTypeID: testTypeID,
                    //   ),
                    // ));
                  }
                  : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: testTypeID == 1 ? Colors.blue : Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            '$testType Test Request',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
