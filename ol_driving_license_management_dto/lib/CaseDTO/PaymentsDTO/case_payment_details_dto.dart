class ClsCasePaymentDetailsDTO {
  int? paymentID;
  double? paymentAmount;
  DateTime? paymentDate;
  String? paymentDetails;
  String? paymentMethod;

  ClsCasePaymentDetailsDTO({
    this.paymentID,
    this.paymentAmount,
    this.paymentDate,
    this.paymentDetails,
    this.paymentMethod,
  });

  factory ClsCasePaymentDetailsDTO.fromJson(Map<String, dynamic> json) {
    return ClsCasePaymentDetailsDTO(
      paymentID: json['PaymentID'] as int?,
      paymentAmount: (json['PaymentAmount'] as num?)?.toDouble(),
      paymentDate:
          json['PaymentDate'] != null
              ? DateTime.tryParse(json['PaymentDate'])
              : null,
      paymentDetails: json['PaymentDetails'] as String?,
      paymentMethod: json['PaymentMethod'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaymentID': paymentID,
      'PaymentAmount': paymentAmount,
      'PaymentDate': paymentDate?.toIso8601String(),
      'PaymentDetails': paymentDetails,
      'PaymentMethod': paymentMethod,
    };
  }
}
