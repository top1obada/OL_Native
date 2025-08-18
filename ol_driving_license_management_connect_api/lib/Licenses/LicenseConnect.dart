import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/LicensesDTOs/TraineeLicenseDTO.dart';

class LicensesConnect {
  LicensesConnect._();

  static Future<List<ClsTraineeLicenseDTO>> getLicenses(int traineeID) async {
    try {
      final response = await DioClient.dio.get(
        'Licenses/GetAllTraineelicenses/$traineeID',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          return [];
        }
        final List<dynamic> listData = data;
        return listData
            .map((json) => ClsTraineeLicenseDTO.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to load Trainee Licenses details: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching Trainee Licenses details: $e');
    }
  }

  static Future<ClsTraineeLicenseDTO?> findByLicenseID(int licenseID) async {
    try {
      final response = await DioClient.dio.get('Licenses/$licenseID');

      if (response.statusCode == 200 && response.data != null) {
        return ClsTraineeLicenseDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
