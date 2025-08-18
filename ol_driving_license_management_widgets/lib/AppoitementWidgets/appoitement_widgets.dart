import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/AppoitementDTO/trainee_appoitement_dto.dart';
import 'package:ol_driving_license_management_widgets/AppoitementWidgets/appoitement_widget.dart';

class WDShowTraineeAppoitements extends StatelessWidget {
  const WDShowTraineeAppoitements({
    super.key,
    required this.traineeAppoitements,
    this.onTap,
  });

  final List<ClsTraineeAppoitementDTO> traineeAppoitements;
  final Function(ClsTraineeAppoitementDTO?)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder:
          (context, index) => WDTraineeAppoitement(
            appoitementDTO: traineeAppoitements[index],
            onTap: onTap,
          ),
      itemCount: traineeAppoitements.length,
    );
  }
}
