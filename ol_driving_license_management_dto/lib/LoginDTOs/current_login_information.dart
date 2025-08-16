class ClsCurrentLoginInformationDTO {
  String? firstName;
  String? userName;
  int? personID;
  int? userID;
  int? traineeID;
  DateTime? joiningDate;

  ClsCurrentLoginInformationDTO({
    this.firstName,
    this.userName,
    this.personID,
    this.userID,
    this.joiningDate,
    this.traineeID,
  });

  factory ClsCurrentLoginInformationDTO.fromJson(Map<String, dynamic> json) {
    return ClsCurrentLoginInformationDTO(
      firstName: json['FirstName'] as String?,
      userName: json['UserName'] as String?,
      personID: json['PersonID'] as int?,
      userID: json['UserID'] as int?,
      joiningDate: json['JoiningDate'] as DateTime?,
      traineeID: json['TraineeID'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'UserName': userName,
      'PersonID': personID,
      'UserID': userID,
      'JoiningDate': joiningDate?.toIso8601String(),
      'TraineeID': traineeID,
    };
  }
}
