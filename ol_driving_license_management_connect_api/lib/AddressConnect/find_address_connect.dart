import 'package:dio/dio.dart';

import '../Settings/general_connect.dart'; // نفس ملف الإعدادات الذي لديك
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart'; // عدل المسار حسب مكان ملف DTO

class AddressConnect {
  AddressConnect._();

  static Future<ClsAddressDTO?> find(int addressID) async {
    try {
      Response response = await DioClient.dio.get('Address/$addressID');

      if (response.statusCode == 200 && response.data != null) {
        return ClsAddressDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
