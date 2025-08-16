class ClsContactInformationDTO {
  int? contactID;
  String? phoneNumber;
  String? email;

  ClsContactInformationDTO({this.contactID, this.phoneNumber, this.email});

  factory ClsContactInformationDTO.fromJson(Map<String, dynamic> json) {
    return ClsContactInformationDTO(
      contactID: json['ContactID'] as int?,
      phoneNumber: json['PhoneNumber'] as String?,
      email: json['Email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ContactID': contactID, 'PhoneNumber': phoneNumber, 'Email': email};
  }
}
