import 'package:dio/dio.dart';

import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';
import '../Settings/general_connect.dart';

class ContactInformationConnect {
  ContactInformationConnect._();

  static Future<ClsContactInformationDTO?> find(int contactID) async {
    try {
      Response response = await DioClient.dio.get(
        'ContactInformation/$contactID',
      );

      if (response.statusCode == 200 && response.data != null) {
        return ClsContactInformationDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
