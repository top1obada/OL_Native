import 'package:flutter/material.dart';
import 'package:my_widgets/CountriesWidgets/countries_drop_down_list_widget.dart';

import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/build_text_form_filed.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/gender_selector_widget.dart';
import 'package:ol_driving_license_management_widgets/WidgetsLibraries/sizing_widgets.dart';

class WDShowUpdateNativePerson extends StatelessWidget {
  const WDShowUpdateNativePerson({super.key, this.nativePersonDTO});

  final ClsNativePersonDTO? nativePersonDTO;

  @override
  Widget build(BuildContext context) {
    final isEnabled = nativePersonDTO != null;

    return FractionallySizedBox(
      widthFactor: SizingWidgets.getPecentSuitableWidgetWidth(context),
      child: Card(
        color: Colors.grey[850], // رمادي غامق مريح للعين
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Person Informations',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  BuildTextFormFiled(
                    label: 'National Number',
                    initialValue: nativePersonDTO?.nationalNumber ?? '',
                    enabled: isEnabled,
                    onChanged: (val) {
                      if (nativePersonDTO != null) {
                        nativePersonDTO!.nationalNumber = val;
                      }
                    },
                  ),

                  const SizedBox(height: 8),
                  BuildTextFormFiled(
                    label: 'First Name',
                    initialValue: nativePersonDTO?.firstName ?? '',
                    enabled: isEnabled,
                    onChanged: (val) {
                      if (nativePersonDTO != null) {
                        nativePersonDTO!.firstName = val;
                      }
                    },
                  ),

                  const SizedBox(height: 8),
                  BuildTextFormFiled(
                    label: 'Second Name',
                    initialValue: nativePersonDTO?.secondName ?? '',
                    enabled: isEnabled,
                    onChanged: (val) {
                      if (nativePersonDTO != null) {
                        nativePersonDTO!.secondName = val;
                      }
                    },
                  ),

                  const SizedBox(height: 8),
                  BuildTextFormFiled(
                    label: 'Last Name:',
                    initialValue: nativePersonDTO?.lastName ?? '',
                    enabled: isEnabled,
                    onChanged: (val) {
                      if (nativePersonDTO != null) {
                        nativePersonDTO!.lastName = val;
                      }
                    },
                  ),

                  const SizedBox(height: 8),
                  // Birthday: Since it's DateTime, let's show a disabled TextField and you can improve to use DatePicker
                  BuildTextFormFiled(
                    label: 'Birthday',
                    initialValue:
                        nativePersonDTO?.birthday != null
                            ? "${nativePersonDTO!.birthday!.year}-${nativePersonDTO!.birthday!.month.toString().padLeft(2, '0')}-${nativePersonDTO!.birthday!.day.toString().padLeft(2, '0')}"
                            : '',
                    enabled: false,
                    onChanged: (_) {},
                  ),

                  const SizedBox(height: 8),

                  WDGenderSelector(
                    initVal: nativePersonDTO!.gender,
                    onChanged: (val) {
                      nativePersonDTO!.gender = val;
                    },
                  ),

                  const SizedBox(height: 8),
                  WDCountriesDropdown(
                    text: 'Nationality Name',
                    value: nativePersonDTO?.nationalityName ?? '',

                    onChanged: (val) {
                      if (nativePersonDTO != null) {
                        nativePersonDTO!.nationalityName = val;
                      }
                    },
                  ),

                  // IDs (personID, nationalityID, contactID, addressID) نادرًا يتم تعديلهم في الواجهة، لذلك عادة لا نعرضهم هنا، لكن لو تريدني أضيفهم قل لي.
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
