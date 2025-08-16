import 'package:dio/dio.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_current_appoitement_dto.dart';

class CaseAppointmentConnect {
  CaseAppointmentConnect._();

  static Future<ClsCaseAppointmentDTO?> getCurrentAppointment(
    int caseID,
  ) async {
    try {
      Response response = await DioClient.dio.get(
        'Case/GetCaseCurrentAppoitement/$caseID',
      );

      if (response.statusCode == 200 && response.data != null) {
        return ClsCaseAppointmentDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
