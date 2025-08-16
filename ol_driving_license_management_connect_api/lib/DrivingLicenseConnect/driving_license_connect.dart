import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/DrivingLicenseTypeDTO/driving_license_type_dto.dart';

class DrivingLicenseTypesConnect {
  DrivingLicenseTypesConnect._();

  static Future<List<ClsDrivingLicenseTypeDTO>>
  getAvailableDrivingLicenseTypesByUserID() async {
    try {
      final response = await DioClient.dio.get('DrivingLicenseType/GetAll');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          return [];
        }
        final List<dynamic> listData = data;
        return listData
            .map((json) => ClsDrivingLicenseTypeDTO.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to load available driving license types: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching available driving license types: $e');
    }
  }
}
