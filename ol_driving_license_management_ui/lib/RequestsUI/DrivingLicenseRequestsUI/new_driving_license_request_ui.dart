import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ol_driving_license_management_dto/DrivingLicenseTypeDTO/driving_license_type_dto.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/DrivingLicenseRequestsDTO/new_driving_license_request.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/DrivingLicenseTypesProviders/driving_license_types_container_provider.dart';
import 'package:ol_driving_license_management_providers/RequestsProviders/NewdrivingLicenseRequestsProviders/add_new_driving_license_request_provider.dart';

import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/DrivingLicenseTypeUI/show_driving_license_type_details_UI.dart';
import 'package:ol_driving_license_management_widgets/RequestWidgets/show_request_widget.dart';

class UINewDrivingLicenseRequest extends StatelessWidget {
  const UINewDrivingLicenseRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var baseCurrent = context.read<PVBaseCurrentLogin>();

    if (Provider.of<PVNewDrivingLicenseRequest?>(context, listen: false) !=
        null) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PVDrivingLicenseTypesContainer(),
          ),
          ChangeNotifierProvider.value(value: baseCurrent),
        ],
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PVNewDrivingLicenseRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => PVDrivingLicenseTypesContainer(),
        ),
        ChangeNotifierProvider.value(value: baseCurrent),
      ],
      child: const _UINewDrivingLicenseRequest(),
    );
  }
}

class _UINewDrivingLicenseRequest extends StatefulWidget {
  const _UINewDrivingLicenseRequest();

  @override
  State<StatefulWidget> createState() => __UINewDrivingLicenseRequest();
}

class __UINewDrivingLicenseRequest extends State<_UINewDrivingLicenseRequest> {
  __UINewDrivingLicenseRequest();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int requestUserID =
          context
              .read<PVBaseCurrentLogin>()
              .currentLoginInformationDTO!
              .userID!;

      context
          .read<PVNewDrivingLicenseRequest>()
          .newDrivingLicenseRequestDTO!
          .requestUserID = requestUserID;

      await context
          .read<PVDrivingLicenseTypesContainer>()
          .loadDrivingLicenseTypes();
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
                Consumer<PVNewDrivingLicenseRequest>(
                  builder:
                      (context, value, child) => WDShowRequestInfoCard(
                        requestDTO: ClsRequestDTO(
                          requestID:
                              value.newDrivingLicenseRequestDTO?.requestID,
                          requestDate:
                              value.newDrivingLicenseRequestDTO?.requestDate,
                          requestType:
                              value.newDrivingLicenseRequestDTO?.requestType,
                          requestState:
                              value.newDrivingLicenseRequestDTO?.requestState,
                          requestUserID:
                              value.newDrivingLicenseRequestDTO?.requestUserID,
                        ),
                        requestApplicantName:
                            context
                                .read<PVBaseCurrentLogin>()
                                .currentLoginInformationDTO!
                                .firstName!,
                      ),
                ),
                const SizedBox(height: 8),
                Selector<
                  PVDrivingLicenseTypesContainer,
                  ClsDrivingLicenseTypeDTO?
                >(
                  selector: (p0, p1) => p1.currentSelectedDTO,
                  builder: (context, value, child) {
                    if (value == null) {
                      return WDShowDrivingLicenseTypeInfoCard(
                        licenseTypeDTO: ClsDrivingLicenseTypeDTO(),
                      );
                    }
                    return WDShowDrivingLicenseTypeInfoCard(
                      licenseTypeDTO: value,
                    );
                  },
                ),
                const SizedBox(height: 8),
                Consumer<PVDrivingLicenseTypesContainer>(
                  builder: (context, container, child) {
                    final items = container.drivingLicenseTypes;

                    if (items.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('No Driving License Types Available'),
                      );
                    }

                    context
                            .read<PVNewDrivingLicenseRequest>()
                            .newDrivingLicenseRequestDTO!
                            .licenseTypeID =
                        container.currentSelectedDTO?.licenseTypeID;

                    return ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'License Type',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width < 400
                                          ? 14
                                          : MediaQuery.of(context).size.width <
                                              600
                                          ? 16
                                          : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                              const SizedBox(height: 8),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value:
                                      container
                                          .currentSelectedDTO
                                          ?.licenseTypeName,
                                  hint: const Text(
                                    'Select Driving License Type',
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 400
                                            ? 14
                                            : MediaQuery.of(
                                                  context,
                                                ).size.width <
                                                600
                                            ? 16
                                            : 20,
                                    color: Colors.black87,
                                  ),
                                  items:
                                      items.map((type) {
                                        return DropdownMenuItem<String>(
                                          value: type.licenseTypeName,
                                          child: Text(
                                            type.licenseTypeName ?? '',
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      container
                                          .changeSelectedDrivingLicenseType(
                                            newValue,
                                          );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 80),
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
              final pro = context.read<PVNewDrivingLicenseRequest>();

              if (pro.newDrivingLicenseRequestDTO?.requestID != null) {
                return;
              }

              await pro.post();

              if (pro.newDrivingLicenseRequestDTO?.requestID != null) {
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
