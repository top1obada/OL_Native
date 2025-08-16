enum EnRequestState {
  pending(1),
  completed(2),
  canceled(3);

  final int value;
  const EnRequestState(this.value);

  static EnRequestState? fromValue(int? value) {
    if (value == null) return null;
    return EnRequestState.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw Exception('Unknown RequestState value: $value'),
    );
  }
}

class ClsUserRequestDTO {
  final int? requestID;
  final DateTime? requestDate;
  final String? requestName;
  final EnRequestState? requestState;
  final DateTime? processedDate;
  final int? processedUserID;
  final String? processedBy;

  ClsUserRequestDTO({
    this.requestID,
    this.requestDate,
    this.requestName,
    this.requestState,
    this.processedDate,
    this.processedUserID,
    this.processedBy,
  });

  factory ClsUserRequestDTO.fromJson(Map<String, dynamic> json) {
    return ClsUserRequestDTO(
      requestID: json['RequestID'] as int?,
      requestDate:
          json['RequestDate'] != null
              ? DateTime.parse(json['RequestDate'])
              : null,
      requestName: json['RequestName'] as String?,
      requestState:
          json['RequestState'] != null
              ? EnRequestState.fromValue(json['RequestState'] as int)
              : null,
      processedDate:
          json['ProcessedDate'] != null
              ? DateTime.parse(json['ProcessedDate'])
              : null,
      processedUserID: json['ProcessedUserID'] as int?,
      processedBy: json['ProcessedBy'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'RequestID': requestID,
    'RequestDate': requestDate?.toIso8601String(),
    'RequestName': requestName,
    'RequestState': requestState?.value,
    'ProcessedDate': processedDate?.toIso8601String(),
    'ProcessedUserID': processedUserID,
    'ProcessedBy': processedBy,
  };
}
