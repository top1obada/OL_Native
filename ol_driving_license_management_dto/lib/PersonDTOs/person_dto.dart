import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';

class ClsPersonDTO {
  int? personID;
  String? nationalNumber;
  String? firstName;
  String? secondName;

  String? lastName;
  DateTime? birthday;
  String? gender;
  String? nationalityName;

  ClsContactInformationDTO? contactInformation;
  ClsAddressDTO? address;

  ClsPersonDTO({
    this.personID,
    this.nationalNumber,
    this.firstName,
    this.secondName,

    this.lastName,
    this.birthday,
    this.gender,
    this.nationalityName,
    this.contactInformation,
    this.address,
  });

  factory ClsPersonDTO.fromJson(Map<String, dynamic> json) {
    return ClsPersonDTO(
      personID: json['PersonID'] as int?,
      nationalNumber: json['NationalNumber'] as String?,
      firstName: json['FirstName'] as String?,
      secondName: json['SecondName'] as String?,

      lastName: json['LastName'] as String?,
      birthday:
          json['Birthday'] != null ? DateTime.parse(json['Birthday']) : null,
      gender:
          json['Gender']
              as String?, // Dart doesn't have `char`, use String with length 1
      nationalityName: json['NationalityName'] as String?,
      contactInformation:
          json['ContactInformation'] != null
              ? ClsContactInformationDTO.fromJson(json['ContactInformation'])
              : null,
      address:
          json['Address'] != null
              ? ClsAddressDTO.fromJson(json['Address'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PersonID': personID,
      'NationalNumber': nationalNumber,
      'FirstName': firstName,
      'SecondName': secondName,

      'LastName': lastName,
      'Birthday': birthday?.toIso8601String(),
      'Gender': gender,
      'NationalityName': nationalityName,
      'ContactInformation': contactInformation?.toJson(),
      'Address': address?.toJson(),
    };
  }
}
