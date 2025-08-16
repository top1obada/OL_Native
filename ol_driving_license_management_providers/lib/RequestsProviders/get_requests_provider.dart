import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/RequestConnect/get_requests_connect.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';

class PVGetRequests extends ChangeNotifier {
  List<ClsRequestDTO>? requests;

  Future<void> getRequests(int userID) async {
    requests = await RequestsConnect.getRequestsByUserID(userID);

    notifyListeners();
  }
}
