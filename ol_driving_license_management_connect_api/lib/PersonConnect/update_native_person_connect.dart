import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/PersonConnect/find_native_person_connect.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import '../Settings/general_connect.dart';

// نتيجة عملية التحديث
class UpdateNativePersonResult {
  final bool success;
  final String? error;

  UpdateNativePersonResult({required this.success, this.error});
}

class UpdateNativePersonConnect {
  UpdateNativePersonConnect._();

  static Future<UpdateNativePersonResult> updateNativePerson(
    ClsNativePersonDTO dto,
  ) async {
    try {
      Response response = await DioClient.dio.put(
        'Person', // 🛠 غيّر هذا حسب مسار الـ API الفعلي
        data: dto.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return UpdateNativePersonResult(success: true);
      } else {
        return UpdateNativePersonResult(
          success: false,
          error: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return UpdateNativePersonResult(success: false, error: e.toString());
    }
  }
}
