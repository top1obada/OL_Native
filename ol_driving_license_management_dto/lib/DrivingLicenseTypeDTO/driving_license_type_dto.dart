class ClsDrivingLicenseTypeDTO {
  int? licenseTypeID;
  String? licenseTypeName;
  double? licenseTypeTotalCost;
  int? periodInMonths;

  ClsDrivingLicenseTypeDTO({
    this.licenseTypeID,
    this.licenseTypeName,
    this.licenseTypeTotalCost,
    this.periodInMonths,
  });

  factory ClsDrivingLicenseTypeDTO.fromJson(Map<String, dynamic> json) {
    return ClsDrivingLicenseTypeDTO(
      licenseTypeID: json['LicenseTypeID'] as int?,
      licenseTypeName: json['LicenseTypeName'] as String?,
      licenseTypeTotalCost:
          json['LicenseTypeTotalCost'] != null
              ? (json['LicenseTypeTotalCost'] as num).toDouble()
              : null,
      periodInMonths: json['PeriodInMonths'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LicenseTypeID': licenseTypeID,
      'LicenseTypeName': licenseTypeName,
      'LicenseTypeTotalCost': licenseTypeTotalCost,
      'PeriodInMonths': periodInMonths,
    };
  }
}
