class ClsLoginDataDTO {
  String? userName;
  String? password;

  ClsLoginDataDTO({this.userName, this.password});

  factory ClsLoginDataDTO.fromJson(Map<String, dynamic> json) {
    return ClsLoginDataDTO(
      userName: json['UserName'] as String?,
      password: json['Password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'UserName': userName, 'Password': password};
  }
}
