enum EnRequestType {
  eNewDrivingLicenseRequest(1),
  eInternationalDrivingLicenseRequest(2),
  eTestRequest(1002);

  final int value;

  const EnRequestType(this.value);

  @override
  String toString() {
    return name.substring(1); // Removes just the leading 'e'
  }

  static EnRequestType? fromValue(int? value) {
    if (value == null) return null;
    try {
      return EnRequestType.values.firstWhere((e) => e.value == value);
    } catch (e) {
      throw Exception('Unknown EnRequestType value: $value');
    }
  }
}

enum EnRequestState {
  ePending(1),
  eAccepted(2),
  eCanceled(3),
  eRejected(4);

  final int value;

  const EnRequestState(this.value);

  @override
  String toString() {
    return name.substring(1); // Removes the leading 'e'
  }

  static EnRequestState? fromValue(int? value) {
    if (value == null) return null;
    try {
      return EnRequestState.values.firstWhere((e) => e.value == value);
    } catch (e) {
      throw Exception('Unknown EnRequestState value: $value');
    }
  }

  // Optional: Get display name with proper formatting
  String get displayName {
    switch (this) {
      case EnRequestState.ePending:
        return 'Pending';
      case EnRequestState.eAccepted:
        return 'Accepted';
      case EnRequestState.eCanceled:
        return 'Canceled';
      case EnRequestState.eRejected:
        return 'Rejected';
    }
  }
}

class ClsRequestDTO {
  int? requestID;
  int? requestUserID;
  DateTime? requestDate;
  EnRequestState? requestState;
  EnRequestType? requestType;
  DateTime? processedDate;
  int? processedUserID;

  ClsRequestDTO({
    this.requestID,
    this.requestUserID,
    this.requestDate,
    this.requestState,
    this.requestType,
    this.processedDate,
    this.processedUserID,
  });

  factory ClsRequestDTO.fromJson(Map<String, dynamic> json) {
    return ClsRequestDTO(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RequestID': requestID,
      'RequestUserID': requestUserID,
      'RequestDate': requestDate?.toIso8601String(),
      'RequestState': requestState?.value,
      'RequestType': requestType?.value,
      'ProcessedDate': processedDate?.toIso8601String(),
      'ProcessedUserID': processedUserID,
    };
  }
}
