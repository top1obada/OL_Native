import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/AppoitementDTO/trainee_appoitement_dto.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/AppoitementProviders/appoitement_Provider.dart';
import 'package:ol_driving_license_management_ui/UIWidgets/const_scaffold.dart';
import 'package:ol_driving_license_management_widgets/AppoitementWidgets/appoitement_widgets.dart';
import 'package:provider/provider.dart';

class UIShowTraineeAppoitements extends StatefulWidget {
  const UIShowTraineeAppoitements({super.key, this.onTap});

  final Function(ClsTraineeAppoitementDTO?)? onTap;

  @override
  State<UIShowTraineeAppoitements> createState() =>
      _UIShowTraineeAppoitementsState();
}

class _UIShowTraineeAppoitementsState extends State<UIShowTraineeAppoitements> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var pvAppoitements = context.read<PVTraineeAppoitements>();
      await pvAppoitements.getTraineeAppoitements(
        context
            .read<PVBaseCurrentLogin>()
            .currentLoginInformationDTO
            ?.traineeID,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Trainee Appointments",
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<PVTraineeAppoitements>(
          builder: (context, pvAppoitements, child) {
            if (pvAppoitements.traineeAppoitements == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (pvAppoitements.traineeAppoitements!.isEmpty) {
              return const Center(
                child: Text(
                  "No Appointments Found",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: WDShowTraineeAppoitements(
                traineeAppoitements: pvAppoitements.traineeAppoitements!,
                onTap: widget.onTap,
              ),
            );
          },
        ),
      ),
    );
  }
}
