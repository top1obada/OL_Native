class ClsRetrivingInsertPersonDTO {
  int? personID;
  int? contactInformationID;
  int? addressID;

  ClsRetrivingInsertPersonDTO({
    this.personID,
    this.contactInformationID,
    this.addressID,
  });

  factory ClsRetrivingInsertPersonDTO.fromJson(Map<String, dynamic> json) {
    return ClsRetrivingInsertPersonDTO(
      personID: json['PersonID'] as int?,
      contactInformationID: json['ContactInformationID'] as int?,
      addressID: json['AddressID'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PersonID': personID,
      'ContactInformationID': contactInformationID,
      'AddressID': addressID,
    };
  }
}
