import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';

import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class RequestsConnect {
  RequestsConnect._();

  static Future<List<ClsRequestDTO>> getRequestsByUserID(int userID) async {
    try {
      final response = await DioClient.dio.get('requests/userid/$userID');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          return [];
        }
        final List<dynamic> listData = data;
        return listData.map((json) => ClsRequestDTO.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load requests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching requests: $e');
    }
  }
}
