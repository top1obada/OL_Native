import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/AddressConnect/update_address_information_connect.dart';
import 'package:ol_driving_license_management_connect_api/ContactInformationConnect/find_contact_information_connect.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';
import '../Settings/general_connect.dart';

// نتيجة عملية التحديث
class UpdateContactInformationResult {
  final bool success;
  final String? error;

  UpdateContactInformationResult({required this.success, this.error});
}

class UpdateContactInformationConnect {
  UpdateContactInformationConnect._();

  static Future<UpdateContactInformationResult> updateContactInformation(
    ClsContactInformationDTO dto,
  ) async {
    try {
      Response response = await DioClient.dio.put(
        'ContactInformation',
        data: dto.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return UpdateContactInformationResult(success: true);
      } else {
        return UpdateContactInformationResult(
          success: false,
          error: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return UpdateContactInformationResult(
        success: false,
        error: e.toString(),
      );
    }
  }
}
