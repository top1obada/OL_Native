class ClsVisionTestResultDTO {
  int? visionTestResultID;
  int? userID;
  int? processedUserID;
  String? path;
  bool? result;

  ClsVisionTestResultDTO({
    this.visionTestResultID,
    this.userID,
    this.processedUserID,
    this.path,
    this.result,
  });

  factory ClsVisionTestResultDTO.fromJson(Map<String, dynamic> json) {
    return ClsVisionTestResultDTO(
      visionTestResultID: json['VisionTestResultID'] as int?,
      userID: json['UserID'] as int?,
      processedUserID: json['ProcessedUserID'] as int?,
      path: json['Path'] as String?,
      result: json['Result'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'VisionTestResultID': visionTestResultID,
      'UserID': userID,
      'ProcessedUserID': processedUserID,
      'Path': path,
      'Result': result,
    };
  }
}
