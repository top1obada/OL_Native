import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/RequestsProviders/get_requests_provider.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/RequestWidgets/show_request_widget.dart';

import 'package:provider/provider.dart';

class UIShowUserRequests extends StatefulWidget {
  const UIShowUserRequests({super.key, required this.userID});

  final int userID;

  @override
  State<UIShowUserRequests> createState() => _UIShowUserRequestsState();
}

class _UIShowUserRequestsState extends State<UIShowUserRequests> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pvRequests = context.read<PVGetRequests>();
      await pvRequests.getRequests(widget.userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "User Requests",
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<PVGetRequests>(
          builder: (context, pvRequests, child) {
            if (pvRequests.requests == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (pvRequests.requests!.isEmpty) {
              return const Center(child: Text('No requests found.'));
            }

            return ListView.builder(
              itemCount: pvRequests.requests!.length,
              itemBuilder: (context, index) {
                final requestDTO = pvRequests.requests![index];
                return WDShowRequestInfoCard(
                  requestDTO: requestDTO,
                  requestApplicantName:
                      context
                          .read<PVBaseCurrentLogin>()
                          .currentLoginInformationDTO!
                          .firstName!,
                  onTap: (requestDTO) {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
