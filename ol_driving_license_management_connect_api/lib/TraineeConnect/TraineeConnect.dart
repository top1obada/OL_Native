import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/TraineeDTO/TraineeRequestDTO.dart';

class UserRequestConnect {
  UserRequestConnect._();

  static Future<List<ClsUserRequestDTO>> getAllUserRequests(int userID) async {
    try {
      Response response = await DioClient.dio.get(
        'Trainee/GetAllUserRequests/$userID',
      );

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> jsonList = response.data as List;
        return jsonList
            .map((json) => ClsUserRequestDTO.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      // Handle error or rethrow
      return [];
    }
  }
}
