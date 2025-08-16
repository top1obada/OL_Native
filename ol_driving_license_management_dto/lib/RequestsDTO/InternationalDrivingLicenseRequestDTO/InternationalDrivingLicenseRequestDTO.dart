import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class CLSInternationalDrivingLicenseRequestDTO extends ClsRequestDTO {
  int? licenseID;

  CLSInternationalDrivingLicenseRequestDTO({
    super.requestID,
    super.requestUserID,
    super.requestDate,
    super.requestState,
    super.requestType,
    super.processedDate,
    super.processedUserID,
    this.licenseID,
  });

  factory CLSInternationalDrivingLicenseRequestDTO.fromJson(Map<String, dynamic> json) {
    return CLSInternationalDrivingLicenseRequestDTO(
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
      licenseID: json['LicenseID'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['LicenseID'] = licenseID;
    return json;
  }
}
