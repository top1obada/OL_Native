class ClsCaseTotalPaymentsDTO {
  int? caseID;
  String? caseName;
  DateTime? startDate;
  double? totalPayments;
  double? due;

  ClsCaseTotalPaymentsDTO({
    this.caseID,
    this.caseName,
    this.startDate,
    this.totalPayments,
    this.due,
  });

  factory ClsCaseTotalPaymentsDTO.fromJson(Map<String, dynamic> json) {
    return ClsCaseTotalPaymentsDTO(
      caseID: json['CaseID'] as int?,
      caseName: json['CaseName'] as String?,
      startDate:
          json['StartDate'] != null
              ? DateTime.tryParse(json['StartDate'])
              : null,
      totalPayments: (json['TotalPayments'] as num?)?.toDouble(),
      due: (json['Due'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CaseID': caseID,
      'CaseName': caseName,
      'StartDate': startDate?.toIso8601String(),
      'TotalPayments': totalPayments,
      'Due': due,
    };
  }
}
