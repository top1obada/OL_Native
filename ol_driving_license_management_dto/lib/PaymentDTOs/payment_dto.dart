class ClsPaymentDTO {
  int? paymentID;
  int? caseID;
  double? paymentAmount;
  DateTime? paymentDate;
  String? details;

  ClsPaymentDTO({
    this.paymentID,
    this.caseID,
    this.paymentAmount,
    this.paymentDate,
    this.details,
  });

  // Factory constructor for JSON parsing
  factory ClsPaymentDTO.fromJson(Map<String, dynamic> json) {
    return ClsPaymentDTO(
      paymentID: json['PaymentID'] as int?,
      caseID: json['CaseID'] as int?,
      paymentAmount: (json['PaymentAmount'] as num?)?.toDouble(),
      paymentDate:
          json['PaymentDate'] != null
              ? DateTime.parse(json['PaymentDate'])
              : null,
      details: json['Details'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'PaymentID': paymentID,
      'CaseID': caseID,
      'PaymentAmount': paymentAmount,
      'PaymentDate': paymentDate?.toIso8601String(),
      'Details': details,
    };
  }
}
