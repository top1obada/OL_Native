import 'package:ol_driving_license_management_dto/PersonDTOs/person_dto.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';

class ClsSignUpDTO {
  ClsPersonDTO? person;
  ClsLoginDataDTO? login;

  ClsSignUpDTO({this.person, this.login});

  factory ClsSignUpDTO.fromJson(Map<String, dynamic> json) {
    return ClsSignUpDTO(
      person: ClsPersonDTO.fromJson(json['Person']),
      login: ClsLoginDataDTO.fromJson(json['Login']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'Person': person?.toJson(), 'Login': login?.toJson()};
  }
}
