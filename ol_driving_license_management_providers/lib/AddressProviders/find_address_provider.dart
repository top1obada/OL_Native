import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_connect_api/AddressConnect/find_address_connect.dart';
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart';

class PVFindAddress extends ChangeNotifier {
  ClsAddressDTO? _addressDTO;

  ClsAddressDTO? get addressDTO => _addressDTO;

  Future<void> find({required int addressID}) async {
    _addressDTO = await AddressConnect.find(addressID);
    notifyListeners();
  }
}
