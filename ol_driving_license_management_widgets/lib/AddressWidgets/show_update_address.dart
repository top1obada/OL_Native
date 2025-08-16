import 'package:flutter/material.dart';
import 'package:my_widgets/CountriesWidgets/countries_drop_down_list_widget.dart';
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/build_text_form_filed.dart';
import 'package:ol_driving_license_management_widgets/WidgetsLibraries/sizing_widgets.dart';

class WDShowUpdateAddress extends StatelessWidget {
  const WDShowUpdateAddress({super.key, this.addressDTO});

  final ClsAddressDTO? addressDTO;

  @override
  Widget build(BuildContext context) {
    final isEnabled = addressDTO != null;

    return FractionallySizedBox(
      widthFactor: SizingWidgets.getPecentSuitableWidgetWidth(context),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Address Informations',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                WDCountriesDropdown(
                  text: 'Nationality Name',
                  value: addressDTO?.countryName ?? '',

                  onChanged: (val) {
                    if (addressDTO != null) {
                      addressDTO!.countryName = val;
                    }
                  },
                ),
                const SizedBox(height: 8),
                BuildTextFormFiled(
                  label: 'City',
                  initialValue: addressDTO?.city ?? '',
                  enabled: isEnabled,
                  onChanged: (val) {
                    if (addressDTO != null) {
                      addressDTO!.city = val;
                    }
                  },
                ),
                const SizedBox(height: 8),
                BuildTextFormFiled(
                  label: 'Town',
                  initialValue: addressDTO?.town ?? '',
                  enabled: isEnabled,
                  onChanged: (val) {
                    if (addressDTO != null) {
                      addressDTO!.town = val;
                    }
                  },
                ),
                const SizedBox(height: 8),
                BuildTextFormFiled(
                  label: 'Street',
                  initialValue: addressDTO?.street ?? '',
                  enabled: isEnabled,
                  onChanged: (val) {
                    if (addressDTO != null) {
                      addressDTO!.street = val;
                    }
                  },
                ),
                const SizedBox(height: 8),
                BuildTextFormFiled(
                  label: 'Building Name',
                  initialValue: addressDTO?.buldingName ?? '',
                  enabled: isEnabled,
                  onChanged: (val) {
                    if (addressDTO != null) {
                      addressDTO!.buldingName = val;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
