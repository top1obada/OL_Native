class ClsNativePersonDTO {
  int? personID;
  String? nationalNumber;
  String? firstName;
  String? secondName;
  String? lastName;

  DateTime? birthday;
  String? gender;
  int? nationalityID;
  String? nationalityName;
  int? contactID;
  int? addressID;

  ClsNativePersonDTO({
    this.personID,
    this.nationalNumber,
    this.firstName,
    this.secondName,
    this.lastName,

    this.birthday,
    this.gender,
    this.nationalityID,
    this.nationalityName,
    this.contactID,
    this.addressID,
  });

  factory ClsNativePersonDTO.fromJson(Map<String, dynamic> json) {
    return ClsNativePersonDTO(
      personID: json['PersonID'] as int?,
      nationalNumber: json['NationalNumber'] as String?,
      firstName: json['FirstName'] as String?,
      secondName: json['SecondName'] as String?,
      lastName: json['LastName'] as String?,

      birthday:
          json['Birthday'] != null ? DateTime.parse(json['Birthday']) : null,
      gender: json['Gender'] as String?, // String of length 1 instead of char
      nationalityID: json['NationalityID'] as int?,
      nationalityName: json['NationalityName'] as String?,
      contactID: json['ContactID'] as int?,
      addressID: json['AddressID'] as int?,
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
      'NationalityID': nationalityID,
      'NationalityName': nationalityName,
      'ContactID': contactID,
      'AddressID': addressID,
    };
  }
}
