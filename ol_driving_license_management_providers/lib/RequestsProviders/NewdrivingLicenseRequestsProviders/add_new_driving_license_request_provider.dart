import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/DrivingLicenseRequestsDTO/new_driving_license_request.dart';
import 'package:ol_driving_license_management_connect_api/RequestConnect/DrivingLicenseRequestConnect/new_driving_license_request_connect.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class PVNewDrivingLicenseRequest extends ChangeNotifier {
  ClsNewDrivingLicenseRequestDTO? newDrivingLicenseRequestDTO;

  PVNewDrivingLicenseRequest() {
    newDrivingLicenseRequestDTO = ClsNewDrivingLicenseRequestDTO(
      requestDate: DateTime.now(),
      requestType: EnRequestType.eNewDrivingLicenseRequest,
      requestState: EnRequestState.ePending,
    );
  }

  Future<void> post() async {
    if (newDrivingLicenseRequestDTO == null) {
      return;
    }

    newDrivingLicenseRequestDTO!.requestID = -1;

    newDrivingLicenseRequestDTO?.requestDate = DateTime.now();

    newDrivingLicenseRequestDTO!
        .requestID = await NewDrivingLicenseRequestConnect.addNewDrivingLicense(
      newDrivingLicenseRequestDTO!,
    );

    notifyListeners();
  }
}
