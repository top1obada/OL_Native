import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/TestRequestConnect/TestRequestConnect.dart';

import 'package:ol_driving_license_management_dto/RequestsDTO/TestRequestDTO/TestRequestDTO.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class PVTestRequestProvider extends ChangeNotifier {
  ClsTestRequestDTO? testRequestDTO;

  PVTestRequestProvider() {
    testRequestDTO = ClsTestRequestDTO(
      requestDate: DateTime.now(),
      requestType: EnRequestType.eTestRequest,
      requestState: EnRequestState.ePending,
    );
  }

  Future<void> post() async {
    if (testRequestDTO == null) {
      return;
    }

    testRequestDTO?.requestDate = DateTime.now();

    testRequestDTO!.requestID = await TestRequestConnect.addTestRequest(
      testRequestDTO!,
    );

    notifyListeners();
  }
}
