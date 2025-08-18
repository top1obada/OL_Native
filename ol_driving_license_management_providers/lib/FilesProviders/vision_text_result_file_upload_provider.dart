import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/FilesConnect/vision_test_result_upload_connect.dart';

class PVVisionTestResultFileUpload extends ChangeNotifier {
  bool _isUploaded = false;

  bool _isLoading = false;

  bool get isUploaded => _isUploaded;

  bool get isLoading => _isLoading;

  int? userID;

  File? visionTestResultFile;

  Future<void> _uploadFile() async {
    _isUploaded = await VisionTestResultUploadConnect.uploadVisionResult(
      file: visionTestResultFile!,
      userID: userID!,
    );

    _isLoading = false;

    notifyListeners();
  }

  Future<void> uploadFile() async {
    _isLoading = true;

    notifyListeners();

    await _uploadFile();
  }
}
