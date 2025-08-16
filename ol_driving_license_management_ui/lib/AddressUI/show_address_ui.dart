import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart';
import 'package:ol_driving_license_management_providers/AddressProviders/update_address_provider.dart';
import 'package:ol_driving_license_management_ui/AddressUI/show_update_address_ui.dart';
import 'package:ol_driving_license_management_widgets/AddressWidgets/show_address.dart';

class UIShowAddress extends StatelessWidget {
  const UIShowAddress({super.key, this.addressDTO});

  final ClsAddressDTO? addressDTO;

  @override
  Widget build(BuildContext context) {
    if (addressDTO == null || addressDTO!.addressID == null) {
      return WDShowAddress(addressDTO: null);
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: ChangeNotifierProvider(
          create: (_) => PVUpdateAddress(),
          child: Builder(
            builder:
                (innerContext) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<PVUpdateAddress>(
                      builder: (context, value, child) {
                        if (value.addressDTO != null) {
                          addressDTO!.city = value.addressDTO!.city;
                          addressDTO!.street = value.addressDTO!.street;
                          addressDTO!.buldingName =
                              value.addressDTO!.buldingName;
                          addressDTO!.town = value.addressDTO!.town;
                          addressDTO!.countryName =
                              value.addressDTO!.countryName;
                          addressDTO!.countryID = value.addressDTO!.countryID;
                        }

                        return WDShowAddress(addressDTO: addressDTO);
                      },
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          final provider = innerContext.read<PVUpdateAddress>();

                          Navigator.push(
                            innerContext,
                            MaterialPageRoute(
                              builder:
                                  (innerContext) =>
                                      ChangeNotifierProvider.value(
                                        value: provider,
                                        child: ShowUpdateAddressUI(
                                          addressID: addressDTO!.addressID!,
                                        ),
                                      ),
                            ),
                          );

                          provider.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Update"),
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
