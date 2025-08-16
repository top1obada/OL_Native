import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/AddressConnect/find_address_connect.dart';
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart';
import '../Settings/general_connect.dart';

// نتيجة عملية التحديث
class UpdateAddressResult {
  final bool success;
  final String? error;

  UpdateAddressResult({required this.success, this.error});
}

class UpdateAddressConnect {
  UpdateAddressConnect._();

  static Future<UpdateAddressResult> updateAddress(ClsAddressDTO dto) async {
    try {
      Response response = await DioClient.dio.put(
        'Address', // 🔁 غيّر هذا حسب مسار الـ API الفعلي
        data: dto.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return UpdateAddressResult(success: true);
      } else {
        return UpdateAddressResult(
          success: false,
          error: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return UpdateAddressResult(success: false, error: e.toString());
    }
  }
}
