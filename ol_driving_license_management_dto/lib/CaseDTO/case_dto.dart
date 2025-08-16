enum EnCaseState {
  eActive(1),
  eCanceled(2),
  eCompleted(3);

  final int value;

  const EnCaseState(this.value);

  @override
  String toString() {
    return name.substring(1, name.length);
  }

  static EnCaseState? fromValue(int? value) {
    if (value == null) return null;
    return EnCaseState.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw Exception('Unknown EnCaseState value: $value'),
    );
  }
}

class ClsCaseDTO {
  DateTime? startedDate;
  DateTime? finishedDate;
  int? caseID;
  double? duePayment;
  double? totalPayments;
  EnCaseState? caseState;
  String? licenseTypeName;

  ClsCaseDTO({
    this.startedDate,
    this.finishedDate,
    this.caseID,
    this.duePayment,
    this.totalPayments,
    this.caseState,
    this.licenseTypeName,
  });

  // Factory constructor for JSON parsing
  factory ClsCaseDTO.fromJson(Map<String, dynamic> json) {
    return ClsCaseDTO(
      startedDate:
          json['StartedDate'] != null
              ? DateTime.parse(json['StartedDate'])
              : null,
      finishedDate:
          json['FinishedDate'] != null
              ? DateTime.parse(json['FinishedDate'])
              : null,
      caseID: json['CaseID'] as int?,
      duePayment: (json['DuePayment'] as num?)?.toDouble(),
      totalPayments: (json['TotalPayments'] as num?)?.toDouble(),
      caseState: EnCaseState.fromValue(json['CaseState'] as int?),
      licenseTypeName: json['LicenseTypeName'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'Started Date': startedDate?.toIso8601String(),
      'Finished Date': finishedDate?.toIso8601String(),
      'CaseID': caseID,
      'DuePayment': duePayment,
      'TotalPayments': totalPayments,
      'CaseState': caseState?.value,
      'LicenseTypeName': licenseTypeName,
    };
  }
}
