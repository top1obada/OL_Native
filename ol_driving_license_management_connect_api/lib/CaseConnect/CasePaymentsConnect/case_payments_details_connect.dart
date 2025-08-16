import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/PaymentsDTO/case_payment_details_dto.dart';

class CasePaymentsDetailsConnect {
  CasePaymentsDetailsConnect._();

  static Future<List<ClsCasePaymentDetailsDTO>> getPaymentsByCaseID(
    int caseID,
  ) async {
    try {
      final response = await DioClient.dio.get(
        'Case/GetCasePaymentsDetails/$caseID',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          return [];
        }
        final List<dynamic> listData = data;
        return listData
            .map((json) => ClsCasePaymentDetailsDTO.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to load payments details: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching payments details: $e');
    }
  }
}
