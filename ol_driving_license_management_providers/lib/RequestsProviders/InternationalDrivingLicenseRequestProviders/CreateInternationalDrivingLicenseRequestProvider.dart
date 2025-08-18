import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/RequestConnect/InternationalDrivingLicenseRequestConnect/InternationalDrivingLicenseRequestConnect.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/InternationalDrivingLicenseRequestDTO/InternationalDrivingLicenseRequestDTO.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class PVCreateInternationalDrivingLicenseRequest extends ChangeNotifier {
  CLSInternationalDrivingLicenseRequestDTO?
  internationalDrivingLicenseRequestDTO;

  PVCreateInternationalDrivingLicenseRequest() {
    internationalDrivingLicenseRequestDTO =
        CLSInternationalDrivingLicenseRequestDTO(
          requestDate: DateTime.now(),
          requestType: EnRequestType.eNewDrivingLicenseRequest,
          requestState: EnRequestState.ePending,
        );
  }

  Future<void> post() async {
    if (internationalDrivingLicenseRequestDTO == null) {
      return;
    }

    internationalDrivingLicenseRequestDTO?.requestDate = DateTime.now();

    internationalDrivingLicenseRequestDTO!.requestID =
        await Internationaldrivinglicenserequestconnect.addInternationalDrivingLicenseRequest(
          internationalDrivingLicenseRequestDTO!,
        );

    notifyListeners();
  }
}
