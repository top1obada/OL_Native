class ClsTraineeLicenseDTO {
  final int? licenseID;
  final String? licenseTypeName;
  final DateTime? issuedDate;
  final DateTime? expirationDate;
  final bool? isInternationalLicense;

  ClsTraineeLicenseDTO({
    this.licenseID,
    this.licenseTypeName,
    this.issuedDate,
    this.expirationDate,
    this.isInternationalLicense,
  });

  factory ClsTraineeLicenseDTO.fromJson(Map<String, dynamic> json) {
    return ClsTraineeLicenseDTO(
      licenseID: json['LicenseID'] as int?,
      licenseTypeName: json['LicenseTypeName'] as String?,
      issuedDate:
          json['IssuedDate'] != null
              ? DateTime.tryParse(json['IssuedDate'])
              : null,
      expirationDate:
          json['ExpirationDate'] != null
              ? DateTime.tryParse(json['ExpirationDate'])
              : null,
      isInternationalLicense: json['IsInternationalLicense'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LicenseID': licenseID,
      'LicenseTypeName': licenseTypeName,
      'IssuedDate': issuedDate?.toIso8601String(),
      'ExpirationDate': expirationDate?.toIso8601String(),
      'IsInternationalLicense': isInternationalLicense,
    };
  }
}
