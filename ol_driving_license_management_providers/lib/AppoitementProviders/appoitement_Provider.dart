import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/AppoitementDTO/trainee_appoitement_dto.dart';
import 'package:ol_driving_license_management_connect_api/AppoitementConnect/appoitement_connect.dart';

class PVTraineeAppoitements extends ChangeNotifier {
  List<ClsTraineeAppoitementDTO>? traineeAppoitements;

  Future<void> getTraineeAppoitements(int? traineeID) async {
    if (traineeID == null) {
      traineeAppoitements = [];
      notifyListeners();
      return;
    }

    traineeAppoitements =
        await TraineeAppoitementsConnect.getAllTraineeAppoitements(traineeID);

    notifyListeners();
  }
}
