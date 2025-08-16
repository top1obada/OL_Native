import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class ClsNewDrivingLicenseRequestDTO extends ClsRequestDTO {
  int? licenseTypeID;

  ClsNewDrivingLicenseRequestDTO({
    super.requestID,
    super.requestUserID,
    super.requestDate,
    super.requestState,
    super.requestType,
    super.processedDate,
    super.processedUserID,
    this.licenseTypeID,
  });

  factory ClsNewDrivingLicenseRequestDTO.fromJson(Map<String, dynamic> json) {
    return ClsNewDrivingLicenseRequestDTO(
      requestID: json['RequestID'] as int?,
      requestUserID: json['RequestUserID'] as int?,
      requestDate:
          json['RequestDate'] != null
              ? DateTime.tryParse(json['RequestDate'])
              : null,
      requestState: EnRequestState.fromValue(json['RequestState'] as int?),
      requestType: EnRequestType.fromValue(json['RequestType'] as int?),
      processedDate:
          json['ProcessedDate'] != null
              ? DateTime.tryParse(json['ProcessedDate'])
              : null,
      processedUserID: json['ProcessedUserID'] as int?,
      licenseTypeID: json['LicenseTypeID'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['LicenseTypeID'] = licenseTypeID;
    return json;
  }
}
