import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/show_cases_widget.dart';

class WDCaseDetails extends StatelessWidget {
  const WDCaseDetails({super.key, required this.caseDTO, this.onTab});

  final ClsCaseDTO caseDTO;

  final Function(ClsCaseDTO?)? onTab;

  Color _getStatusColor(EnCaseState? state) {
    if (state == null) return Colors.grey;

    switch (state) {
      case EnCaseState.eActive:
        return Colors.green;
      case EnCaseState.eCanceled:
        return Colors.red;
      case EnCaseState.eCompleted: // Changed from 'finished' to match your enum
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(caseDTO.caseState);

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const Icon(Icons.folder_open, color: Colors.blue),
          title: Text(
            "Case ID: ${caseDTO.caseID ?? 'N/A'}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Case Name: ${caseDTO.licenseTypeName ?? '-'}",
                style: TextStyle(color: Colors.blueGrey[800]),
              ),
              Text(
                "Started: ${caseDTO.startedDate != null ? caseDTO.startedDate!.toLocal().toString().split(' ')[0] : '-'}",
                style: TextStyle(color: Colors.grey[800]),
              ),
              Text(
                "Finished: ${caseDTO.finishedDate != null ? caseDTO.finishedDate!.toLocal().toString().split(' ')[0] : '-'}",
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
                caseDTO.caseState?.toString() ?? '-',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          onTap: () {
            onTab?.call(caseDTO);
          },
        ),
      ),
    );
  }
}
