import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/TestConnect/TestConnect.dart';
import 'package:ol_driving_license_management_dto/TestDTO/TestDTO.dart';

class PVFindTest extends ChangeNotifier {
  ClsTestDTO? _testDTO;

  ClsTestDTO? get testDTO => _testDTO;

  Future<void> find({required int testID}) async {
    _testDTO = await TestConnect.find(testID);
    notifyListeners();
  }
}
