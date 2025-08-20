import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/RequestsProviders/TestRequestProviders/CreateTestRequestProvider.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/case_widget_card.dart';

import 'package:ol_driving_license_management_widgets/RequestWidgets/show_request_widget.dart';
import 'package:provider/provider.dart';

class UITestRequest extends StatefulWidget {
  const UITestRequest({
    super.key,
    required this.caseDTO,
    required this.testTypeID,
  });

  final ClsCaseDTO? caseDTO;

  final int testTypeID;

  @override
  State<UITestRequest> createState() => _UITestRequestState();
}

class _UITestRequestState extends State<UITestRequest> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pro = context.read<PVTestRequestProvider>();
      pro.testRequestDTO!.caseID = widget.caseDTO!.caseID;

      pro.testRequestDTO!.requestUserID =
          context
              .read<PVBaseCurrentLogin>()
              .currentLoginInformationDTO!
              .userID!;

      pro.testRequestDTO!.testTypeID = widget.testTypeID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'New Test Request',
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<PVTestRequestProvider>(
                  builder:
                      (context, value, child) => WDShowRequestInfoCard(
                        requestDTO: value.testRequestDTO!,
                        requestApplicantName:
                            context
                                .read<PVBaseCurrentLogin>()
                                .currentLoginInformationDTO!
                                .firstName!,
                      ),
                ),
                const SizedBox(height: 8),

                WDCaseDetailsCard(caseDTO: widget.caseDTO!),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Test Type: ',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    widget.testTypeID == 1
                        ? Text(
                          'Theory Test',
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        )
                        : Text(
                          'Practical Test',
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () async {
                final pro = context.read<PVTestRequestProvider>();

                if (pro.testRequestDTO?.requestID != null) {
                  return;
                }

                await pro.post();

                if (pro.testRequestDTO?.requestID != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Request submitted successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2), // Show for 2 seconds
                    ),
                  );

                  // Close the screen after 2 seconds
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) {
                      Navigator.of(context).pop(); // Close the current screen
                    }
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Failed to submit the request. Please try again.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },

              icon: const Icon(Icons.send),
              label: const Text('Request', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
