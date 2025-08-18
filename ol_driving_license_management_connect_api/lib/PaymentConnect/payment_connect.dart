import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/PaymentDTOs/payment_dto.dart';

class PaymentConnect {
  PaymentConnect._();

  /// Add a new payment
  /// Returns the PaymentID if successful or throws an exception if failed
  static Future<int?> addPayment(ClsPaymentDTO dto) async {
    try {
      final response = await DioClient.dio.post('Payment', data: dto.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          if (response.data is num) {
            return (response.data as num).toInt();
          }
          // Handle case where response.data is a Map
          else if (response.data is Map<String, dynamic>) {
            final data = response.data as Map<String, dynamic>;
            return data['PaymentID'] as int?;
          }
        }
        return null;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to add new payment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add new payment: $e');
    }
  }
}
