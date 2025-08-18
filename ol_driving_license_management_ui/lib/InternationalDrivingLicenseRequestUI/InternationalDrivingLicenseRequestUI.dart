import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/RequestsProviders/InternationalDrivingLicenseRequestProviders/CreateInternationalDrivingLicenseRequestProvider.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/LicensesWidgets/TraineeLicenseWidgetRequest.dart';
import 'package:ol_driving_license_management_widgets/RequestWidgets/show_request_widget.dart';
import 'package:provider/provider.dart';
import 'package:ol_driving_license_management_providers/LicensesProviders/FindTraineeLicenseProvider.dart';

class UIInternationalDrivingLicenseRequest extends StatefulWidget {
  const UIInternationalDrivingLicenseRequest({
    super.key,
    required this.licenseID,
  });

  final int licenseID;

  @override
  State<UIInternationalDrivingLicenseRequest> createState() =>
      _UIInternationalDrivingLicenseRequest();
}

class _UIInternationalDrivingLicenseRequest
    extends State<UIInternationalDrivingLicenseRequest> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<PVFindTraineeLicense>().findTraineeLicense(
        widget.licenseID,
      );

      var pro = context.read<PVCreateInternationalDrivingLicenseRequest>();

      pro.internationalDrivingLicenseRequestDTO!.requestUserID =
          context.read<PVBaseCurrentLogin>().currentLoginInformationDTO!.userID;

      pro.internationalDrivingLicenseRequestDTO!.licenseID = widget.licenseID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'New Driving License Request',
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<PVCreateInternationalDrivingLicenseRequest>(
                  builder:
                      (context, value, child) => WDShowRequestInfoCard(
                        requestDTO:
                            value.internationalDrivingLicenseRequestDTO!,
                        requestApplicantName:
                            context
                                .read<PVBaseCurrentLogin>()
                                .currentLoginInformationDTO!
                                .firstName!,
                      ),
                ),
                const SizedBox(height: 8),
                Consumer<PVFindTraineeLicense>(
                  builder: (context, value, child) {
                    if (value.traineeLicense == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return WDTraineeLicenseDetailsRequest(
                      traineeLicenseDTO: value.traineeLicense!,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () async {
              final pro =
                  context.read<PVCreateInternationalDrivingLicenseRequest>();

              if (pro.internationalDrivingLicenseRequestDTO?.requestID !=
                      null ||
                  pro.internationalDrivingLicenseRequestDTO!.requestUserID ==
                      null) {
                return;
              }

              await pro.post();

              if (pro.internationalDrivingLicenseRequestDTO?.requestID !=
                  null) {
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
    );
  }
}
