class ClsCaseAppointmentDTO {
  final int? appointmentID;
  final DateTime? appointmentDate;
  final String? testTypeName;
  final int? requestID;

  ClsCaseAppointmentDTO({
    this.appointmentID,
    this.appointmentDate,
    this.testTypeName,
    this.requestID,
  });

  factory ClsCaseAppointmentDTO.fromJson(Map<String, dynamic> json) {
    return ClsCaseAppointmentDTO(
      appointmentID: json['AppoitementID'] as int?,
      appointmentDate:
          json['AppoitementDate'] != null
              ? DateTime.parse(json['AppoitementDate'])
              : null,
      testTypeName: json['TestTypeName'] as String?,
      requestID: json['RequestID'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'AppoitementID': appointmentID,
    'AppoitementDate': appointmentDate?.toIso8601String(),
    'TestTypeName': testTypeName,
    'RequestID': requestID,
  };
}
