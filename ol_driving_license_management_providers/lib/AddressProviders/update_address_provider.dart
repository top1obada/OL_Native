import 'package:flutter/cupertino.dart';
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart';
import 'package:ol_driving_license_management_connect_api/AddressConnect/update_address_information_connect.dart';
import 'package:ol_driving_license_management_connect_api/AddressConnect/find_address_connect.dart';

class PVUpdateAddress with ChangeNotifier {
  ClsAddressDTO? _addressDTO;

  ClsAddressDTO? get addressDTO => _addressDTO;

  void loadAddress(ClsAddressDTO address) {
    _addressDTO = address;
  }

  void clear() {
    _addressDTO = null;
  }

  Future<void> fetch({required int addressID}) async {
    _addressDTO = await AddressConnect.find(addressID);
    notifyListeners();
  }

  Future<UpdateAddressResult> save() async {
    if (_addressDTO == null) {
      return UpdateAddressResult(
        success: false,
        error: "No address information provided.",
      );
    }

    final result = await UpdateAddressConnect.updateAddress(_addressDTO!);

    if (result.success) {
      notifyListeners();
    }

    return result;
  }
}
