import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/PersonConnect/find_native_person_connect.dart';

import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/person_dto.dart';
import '../Settings/general_connect.dart';

class CompletedPersonConnect {
  CompletedPersonConnect._();

  static Future<ClsPersonDTO?> find(int personID) async {
    try {
      Response response = await DioClient.dio.get('Person/$personID');

      if (response.statusCode == 200 && response.data != null) {
        return ClsPersonDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
