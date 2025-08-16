import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_total_payments_dto.dart';

class CaseTotalPaymentsConnect {
  CaseTotalPaymentsConnect._();

  static Future<List<ClsCaseTotalPaymentsDTO>> getCasesByTraineeID(
    int traineeID,
  ) async {
    try {
      final response = await DioClient.dio.get(
        'Case/GetTraineeCasesTotalPayments/$traineeID',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          return [];
        }
        final List<dynamic> listData = data;
        return listData
            .map((json) => ClsCaseTotalPaymentsDTO.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load cases: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching cases: $e');
    }
  }
}
