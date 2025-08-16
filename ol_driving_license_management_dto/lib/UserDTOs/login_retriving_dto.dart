class ClsUserLoginRetrivingDTO {
  int userID;
  String userName;
  int? personID;
  DateTime? joiningDate;

  ClsUserLoginRetrivingDTO({
    required this.userID,
    required this.userName,
    this.personID,
    this.joiningDate,
  });

  factory ClsUserLoginRetrivingDTO.fromJson(Map<String, dynamic> json) {
    return ClsUserLoginRetrivingDTO(
      userID: json['UserID'] as int,
      userName: json['UserName'] as String,
      personID: json['PersonID'] as int?,
      joiningDate: json['JoiningDate'] != null
          ? DateTime.parse(json['JoiningDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'UserName': userName,
      'PersonID': personID,
      'JoiningDate': joiningDate?.toIso8601String(),
    };
  }
}
