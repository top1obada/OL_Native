import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/native_person_dto.dart';
import 'package:ol_driving_license_management_providers/PersonProviders/update_person_provider.dart';
import 'package:ol_driving_license_management_ui/PersonUI/show_update_native_person_ui.dart';
import 'package:ol_driving_license_management_widgets/PersonsWidgets/show_native_person.dart';
import 'package:provider/provider.dart';

class UIShowNativePersonInfo extends StatelessWidget {
  const UIShowNativePersonInfo({super.key, this.nativePersonDTO});

  final ClsNativePersonDTO? nativePersonDTO;

  @override
  Widget build(BuildContext context) {
    if (nativePersonDTO == null || nativePersonDTO!.personID == null) {
      return WDShowNativePerson(nativePersonDTO: null);
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: ChangeNotifierProvider(
          create: (_) => PVUpdateNativePerson(),
          child: Builder(
            builder:
                (innerContext) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<PVUpdateNativePerson>(
                      builder: (context, value, child) {
                        if (value.nativePersonDTO != null) {
                          nativePersonDTO!.firstName =
                              value.nativePersonDTO!.firstName;
                          nativePersonDTO!.secondName =
                              value.nativePersonDTO!.secondName;
                          nativePersonDTO!.lastName =
                              value.nativePersonDTO!.lastName;
                          nativePersonDTO!.birthday =
                              value.nativePersonDTO!.birthday;
                          nativePersonDTO!.gender =
                              value.nativePersonDTO!.gender;
                          nativePersonDTO!.nationalityID =
                              value.nativePersonDTO!.nationalityID;
                          nativePersonDTO!.nationalityName =
                              value.nativePersonDTO!.nationalityName;
                        }

                        return WDShowNativePerson(
                          nativePersonDTO: nativePersonDTO,
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          final provider =
                              innerContext.read<PVUpdateNativePerson>();

                          Navigator.push(
                            innerContext,
                            MaterialPageRoute(
                              builder:
                                  (innerContext) =>
                                      ChangeNotifierProvider.value(
                                        value: provider,
                                        child: ShowUpdateNativePersonUI(
                                          personID: nativePersonDTO!.personID!,
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
