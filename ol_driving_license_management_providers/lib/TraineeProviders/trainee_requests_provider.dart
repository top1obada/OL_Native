import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/TraineeConnect/TraineeConnect.dart';
import 'package:ol_driving_license_management_dto/TraineeDTO/TraineeRequestDTO.dart';

class PVUserRequests extends ChangeNotifier {
  List<ClsUserRequestDTO>? userRequests;

  Future<void> loadUserRequests(int userID) async {
    userRequests = await UserRequestConnect.getAllUserRequests(userID);
    notifyListeners();
  }
}
