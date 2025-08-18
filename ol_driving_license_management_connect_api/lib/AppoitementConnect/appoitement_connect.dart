import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/AppoitementDTO/trainee_appoitement_dto.dart';

class TraineeAppoitementsConnect {
  TraineeAppoitementsConnect._();

  static Future<List<ClsTraineeAppoitementDTO>> getAllTraineeAppoitements(
    int traineeID,
  ) async {
    try {
      final response = await DioClient.dio.get(
        'Appoitement/GetTraineeAppoitements/$traineeID',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          return [];
        }
        final List<dynamic> listData = data;
        return listData
            .map((json) => ClsTraineeAppoitementDTO.fromJson(json))
            .toList();
      } else {
        throw Exception(
          'Failed to load trainee appointments: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching trainee appointments: $e');
    }
  }
}
