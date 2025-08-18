import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/AppoitementDTO/trainee_appoitement_dto.dart';

class WDTraineeAppoitement extends StatelessWidget {
  const WDTraineeAppoitement({
    super.key,
    required this.appoitementDTO,
    this.onTap,
  });

  final ClsTraineeAppoitementDTO appoitementDTO;
  final Function(ClsTraineeAppoitementDTO?)? onTap;

  Color _getStatusColor(EnAppoitementState? state) {
    if (state == null) return Colors.grey;

    switch (state) {
      case EnAppoitementState.ePending:
        return Colors.orange;
      case EnAppoitementState.eCancled:
        return Colors.red;
      case EnAppoitementState.eCompleated:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(appoitementDTO.appoitementState);

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const Icon(Icons.calendar_today, color: Colors.blue),
          title: Text(
            "Appointment ID: ${appoitementDTO.appoitementID ?? 'N/A'}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Test Type: ${appoitementDTO.testTypeName ?? '-'}",
                style: TextStyle(color: Colors.blueGrey[800]),
              ),
              Text(
                "License Type: ${appoitementDTO.licenseTypeName ?? '-'}",
                style: TextStyle(color: Colors.blueGrey[800]),
              ),
              Text(
                "Date: ${appoitementDTO.appoitementDate != null ? appoitementDTO.appoitementDate!.toLocal().toString().split(' ')[0] : '-'}",
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: statusColor, size: 12),
              const SizedBox(height: 4),
              Text(
                appoitementDTO.appoitementState?.toString() ?? '-',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          onTap: () {
            onTap?.call(appoitementDTO);
          },
        ),
      ),
    );
  }
}
