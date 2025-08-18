import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/InternationalDrivingLicenseRequestDTO/InternationalDrivingLicenseRequestDTO.dart';

class Internationaldrivinglicenserequestconnect {
  Internationaldrivinglicenserequestconnect._();

  /// إضافة طلب رخصة قيادة جديد
  /// ترجع الـ RequestID إذا نجح أو ترمي استثناء إذا فشل
  static Future<int?> addInternationalDrivingLicenseRequest(
    CLSInternationalDrivingLicenseRequestDTO dto,
  ) async {
    try {
      final response = await DioClient.dio.post(
        'InternationalDrivingLicenseRequest',
        data: dto.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          // Handle case where response.data is a number (like 26 or 58)
          if (response.data is num) {
            return (response.data as num).toInt();
          }
          // Handle case where response.data is a Map
          else if (response.data is Map<String, dynamic>) {
            final data = response.data as Map<String, dynamic>;
            return data['RequestID'] as int?;
          }
        }
        return null;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to add new driving license request: ${e.message}',
      );
    } catch (e) {
      throw Exception('Failed to add new driving license request: $e');
    }
  }
}
