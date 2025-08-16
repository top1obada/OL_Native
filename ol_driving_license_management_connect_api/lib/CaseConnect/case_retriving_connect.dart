import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';

class CaseConnect {
  CaseConnect._();

  static Future<List<ClsCaseDTO>> getCases(int traineeID) async {
    try {
      final response = await DioClient.dio.get('Case/GetAll/$traineeID');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) return [];
        final List<dynamic> listData = data;
        return listData.map((json) => ClsCaseDTO.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cases: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching cases: $e');
    }
  }

  static Future<ClsCaseDTO?> findCase(int caseID) async {
    try {
      final response = await DioClient.dio.get('Case/$caseID');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) return null;
        return ClsCaseDTO.fromJson(data);
      } else if (response.statusCode == 500) {
        throw Exception(response.data['message'] ?? 'Server error occurred');
      } else {
        throw Exception('Failed to load case: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching case: $e');
    }
  }
}
