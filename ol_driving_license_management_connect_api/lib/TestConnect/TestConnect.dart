import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/TestDTO/CaseTestDTO.dart';
import 'package:ol_driving_license_management_dto/TestDTO/TestDTO.dart';

class TestConnect {
  TestConnect._();

  static Future<ClsTestDTO?> find(int testID) async {
    try {
      Response response = await DioClient.dio.get('tests/$testID');

      if (response.statusCode == 200 && response.data != null) {
        return ClsTestDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> didUserPassTest(ClsCaseTestDTO dto) async {
    try {
      final response = await DioClient.dio.get(
        'Test/IsCasePassTest',
        data: dto.toJson(),
      );

      if (response.statusCode == 200) {
        if (response.data != null) {
          // Handle case where response.data is a boolean
          if (response.data is bool) {
            return response.data as bool;
          }
          // Handle case where response.data is a Map
          else if (response.data is Map<String, dynamic>) {
            final data = response.data as Map<String, dynamic>;
            return data['didPass'] as bool;
          }
        }
        return false;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to check test pass status: ${e.message}');
    } catch (e) {
      throw Exception('Failed to check test pass status: $e');
    }
  }
}
