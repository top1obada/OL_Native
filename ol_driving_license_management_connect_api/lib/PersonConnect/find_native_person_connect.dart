import 'package:dio/dio.dart';

import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import '../Settings/general_connect.dart'; // تأكد من صحة المسار

class NativePersonConnect {
  NativePersonConnect._();

  static Future<ClsNativePersonDTO?> find(int personID) async {
    try {
      Response response = await DioClient.dio.get('Person/$personID');

      if (response.statusCode == 200 && response.data != null) {
        return ClsNativePersonDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
