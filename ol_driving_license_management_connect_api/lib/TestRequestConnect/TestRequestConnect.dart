import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';

import 'package:ol_driving_license_management_dto/RequestsDTO/TestRequestDTO/TestRequestDTO.dart';

class TestRequestConnect {
  TestRequestConnect._();

  /// إضافة طلب رخصة قيادة جديد
  /// ترجع الـ RequestID إذا نجح أو ترمي استثناء إذا فشل
  static Future<int?> addTestRequest(ClsTestRequestDTO dto) async {
    try {
      final response = await DioClient.dio.post(
        'TestRequest',
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
      throw Exception('Failed to add Test Request: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add Test Request: $e');
    }
  }
}
