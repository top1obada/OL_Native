import 'package:flutter/foundation.dart';
import 'package:ol_driving_license_management_connect_api/DrivingLicenseConnect/driving_license_connect.dart';
import 'package:ol_driving_license_management_dto/DrivingLicenseTypeDTO/driving_license_type_dto.dart';

class PVDrivingLicenseTypesContainer extends ChangeNotifier {
  List<ClsDrivingLicenseTypeDTO> _drivingLicenseTypes = [];
  ClsDrivingLicenseTypeDTO? _currentSelectedDTO;

  List<ClsDrivingLicenseTypeDTO> get drivingLicenseTypes =>
      _drivingLicenseTypes;

  ClsDrivingLicenseTypeDTO? get currentSelectedDTO => _currentSelectedDTO;

  void changeSelectedDrivingLicenseType(String drivingLicenseTypeName) {
    if (_currentSelectedDTO == null) {
      _currentSelectedDTO = drivingLicenseTypes.firstWhere(
        (dto) => dto.licenseTypeName == drivingLicenseTypeName,
      );
      if (_currentSelectedDTO != null) {
        notifyListeners();
      }
      return;
    }

    if (drivingLicenseTypeName != _currentSelectedDTO!.licenseTypeName) {
      _currentSelectedDTO =
          _currentSelectedDTO = drivingLicenseTypes.firstWhere(
            (dto) => dto.licenseTypeName == drivingLicenseTypeName,
          );
      notifyListeners();
    }
  }

  Future<void> loadDrivingLicenseTypes() async {
    try {
      final list =
          await DrivingLicenseTypesConnect.getAvailableDrivingLicenseTypesByUserID();
      _drivingLicenseTypes = list;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
