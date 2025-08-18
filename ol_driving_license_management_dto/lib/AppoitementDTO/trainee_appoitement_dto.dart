enum EnAppoitementState {
  ePending(1),
  eCancled(2),
  eCompleated(3);

  final int value;

  const EnAppoitementState(this.value);

  @override
  String toString() {
    return name.substring(
      1,
      name.length,
    ); // Returns "Pending", "Cancled", "Compleated"
  }

  static EnAppoitementState? fromValue(int? value) {
    if (value == null) return null;
    return EnAppoitementState.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw Exception('Unknown EnAppoitementState value: $value'),
    );
  }
}

class ClsTraineeAppoitementDTO {
  int? appoitementID;
  DateTime? appoitementDate;
  EnAppoitementState? appoitementState;
  int? requestID;
  String? testTypeName;
  String? licenseTypeName;

  ClsTraineeAppoitementDTO({
    this.appoitementID,
    this.appoitementDate,
    this.appoitementState,
    this.requestID,
    this.testTypeName,
    this.licenseTypeName,
  });

  // Factory constructor for JSON parsing
  factory ClsTraineeAppoitementDTO.fromJson(Map<String, dynamic> json) {
    return ClsTraineeAppoitementDTO(
      appoitementID: json['AppoitementID'] as int?,
      appoitementDate:
          json['AppoitementDate'] != null
              ? DateTime.parse(json['AppoitementDate'])
              : null,
      appoitementState: EnAppoitementState.fromValue(
        json['AppoitementState'] as int?,
      ),
      requestID: json['RequestID'] as int?,
      testTypeName: json['TestTypeName'] as String?,
      licenseTypeName: json['LicenseTypeName'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'AppoitementID': appoitementID,
      'AppoitementDate': appoitementDate?.toIso8601String(),
      'AppoitementState': appoitementState?.value,
      'RequestID': requestID,
      'TestTypeName': testTypeName,
      'LicenseTypeName': licenseTypeName,
    };
  }
}
