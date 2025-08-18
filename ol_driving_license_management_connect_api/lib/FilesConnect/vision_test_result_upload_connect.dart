import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ol_driving_license_management_connect_api/Settings/general_connect.dart';
import 'package:ol_driving_license_management_dto/VisionTestRequestDTO/VisionTestResult.dart';

class VisionTestResultUploadConnect {
  VisionTestResultUploadConnect._();

  static Future<bool> uploadVisionResult({
    required int userID,
    required File file,
  }) async {
    try {
      final formData = FormData.fromMap({
        'File': await MultipartFile.fromFile(
          // F كبيرة
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType('application', 'pdf'),
        ),
      });

      final response = await DioClient.dio.post(
        'VisionTestResult/$userID',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          sendTimeout: const Duration(minutes: 2),
          receiveTimeout: const Duration(minutes: 2),
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("❌ خطأ أثناء رفع النتيجة: $e");
      return false;
    }
  }
}
