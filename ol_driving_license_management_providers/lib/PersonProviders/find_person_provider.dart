import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import 'package:ol_driving_license_management_connect_api/PersonConnect/find_native_person_connect.dart';

class PVFindNativePerson extends ChangeNotifier {
  ClsNativePersonDTO? _nativePersonDTO;

  ClsNativePersonDTO? get nativePersonDTO => _nativePersonDTO;

  Future<void> find({required int personID}) async {
    _nativePersonDTO = await NativePersonConnect.find(personID);
    notifyListeners();
  }
}
