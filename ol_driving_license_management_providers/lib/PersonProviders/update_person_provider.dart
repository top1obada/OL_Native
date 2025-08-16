import 'package:flutter/cupertino.dart';
import 'package:ol_driving_license_management_connect_api/PersonConnect/find_native_person_connect.dart';
import 'package:ol_driving_license_management_connect_api/PersonConnect/update_native_person_connect.dart';

import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';

class PVUpdateNativePerson with ChangeNotifier {
  ClsNativePersonDTO? _nativePersonDTO;

  ClsNativePersonDTO? get nativePersonDTO => _nativePersonDTO;

  void loadNativePerson(ClsNativePersonDTO person) {
    _nativePersonDTO = person;
  }

  void clear() {
    _nativePersonDTO = null;
  }

  Future<void> fetch({required int personID}) async {
    _nativePersonDTO = await NativePersonConnect.find(personID);
    notifyListeners();
  }

  Future<UpdateNativePersonResult> save() async {
    if (_nativePersonDTO == null) {
      return UpdateNativePersonResult(
        success: false,
        error: "No native person information provided.",
      );
    }

    final result = await UpdateNativePersonConnect.updateNativePerson(
      _nativePersonDTO!,
    );

    if (result.success) {
      notifyListeners();
    }

    return result;
  }
}
