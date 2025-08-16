class ClsCaseTestDTO {
  int? caseID;
  int? testTypeID;

  ClsCaseTestDTO({this.caseID, this.testTypeID});

  factory ClsCaseTestDTO.fromJson(Map<String, dynamic> json) {
    return ClsCaseTestDTO(
      caseID: json['caseID'] as int?,
      testTypeID: json['testTypeID'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'caseID': caseID, 'testTypeID': testTypeID};
  }
}
