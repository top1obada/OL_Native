import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class ClsTestRequestDTO extends ClsRequestDTO {
  int? testTypeID;
  int? caseID;

  ClsTestRequestDTO({
    super.requestID,
    super.requestUserID,
    super.requestDate,
    super.requestState,
    super.requestType,
    super.processedDate,
    super.processedUserID,
    this.testTypeID,
    this.caseID,
  });

  factory ClsTestRequestDTO.fromJson(Map<String, dynamic> json) {
    return ClsTestRequestDTO(
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
      testTypeID: json['TestTypeID'] as int?,
      caseID: json['CaseID'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['TestTypeID'] = testTypeID;
    json['CaseID'] = caseID;
    return json;
  }
}
