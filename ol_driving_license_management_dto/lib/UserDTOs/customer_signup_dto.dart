import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/person_dto.dart';

class ClsCustomerSignUpDTO {
  ClsPersonDTO? person;
  ClsLoginDataDTO? loginData;

  ClsCustomerSignUpDTO({this.person, this.loginData});

  factory ClsCustomerSignUpDTO.fromJson(Map<String, dynamic> json) {
    return ClsCustomerSignUpDTO(
      person:
          json['Person'] != null ? ClsPersonDTO.fromJson(json['Person']) : null,
      loginData:
          json['LoginData'] != null
              ? ClsLoginDataDTO.fromJson(json['LoginData'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'Person': person?.toJson(), 'LoginData': loginData?.toJson()};
  }
}
