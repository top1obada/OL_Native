class ClsAddressDTO {
  int? addressID;
  int? countryID;
  String? countryName;
  String? city;
  String? town;
  String? street;
  String? buldingName;

  ClsAddressDTO({
    this.addressID,
    this.countryID,
    this.countryName,
    this.city,
    this.town,
    this.street,
    this.buldingName,
  });

  factory ClsAddressDTO.fromJson(Map<String, dynamic> json) {
    return ClsAddressDTO(
      addressID: json['AddressID'] as int?,
      countryID: json['CountryID'] as int?,
      countryName: json['CountryName'] as String?,
      city: json['City'] as String?,
      town: json['Town'] as String?,
      street: json['Street'] as String?,
      buldingName: json['BuldingName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AddressID': addressID,
      'CountryID': countryID,
      'CountryName': countryName,
      'City': city,
      'Town': town,
      'Street': street,
      'BuldingName': buldingName,
    };
  }
}
