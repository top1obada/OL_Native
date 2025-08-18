// test_dto.dart

class ClsTestDTO {
  int? testID;
  int? appoitementID;
  int? testTypeID;
  bool? result;
  int? requestID;
  String? testTypeName;

  ClsTestDTO({
    this.testID,
    this.appoitementID,
    this.testTypeID,
    this.result,
    this.requestID,
    this.testTypeName,
  });

  factory ClsTestDTO.fromJson(Map<String, dynamic> json) {
    return ClsTestDTO(
      testID: json['TestID'] as int?,
      appoitementID: json['AppoitementID'] as int?,
      testTypeID: json['TestTypeID'] as int?,
      result: json['Result'] as bool?,
      requestID: json['RequestID'] as int?,
      testTypeName: json['TestTypeName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TestID': testID,
      'AppoitementID': appoitementID,
      'TestTypeID': testTypeID,
      'Result': result,
      'RequestID': requestID,
      'TestTypeName': testTypeName,
    };
  }
}
