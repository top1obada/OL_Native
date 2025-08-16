import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/CompletedPersonConnect/find_completed_person_connect.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/person_dto.dart';

class PVFindCompletedPerson extends ChangeNotifier {
  PVFindCompletedPerson();

  ClsPersonDTO? _personDTO;

  ClsPersonDTO? get personDTO => _personDTO;

  Future<void> find({required int personID}) async {
    _personDTO = await CompletedPersonConnect.find(personID);

    notifyListeners();
  }
}
