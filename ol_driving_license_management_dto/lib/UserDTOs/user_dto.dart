class ClsUserDTO {
  int userID;
  String userName;
  String password;
  int personID;
  DateTime joiningDate;

  ClsUserDTO({
    required this.userID,
    required this.userName,
    required this.password,
    required this.personID,
    required this.joiningDate,
  });

  factory ClsUserDTO.fromJson(Map<String, dynamic> json) {
    return ClsUserDTO(
      userID: json['UserID'] as int,
      userName: json['UserName'] as String,
      password: json['Password'] as String,
      personID: json['PersonID'] as int,
      joiningDate: DateTime.parse(json['JoiningDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'UserName': userName,
      'Password': password,
      'PersonID': personID,
      'JoiningDate': joiningDate.toIso8601String(),
    };
  }
}
