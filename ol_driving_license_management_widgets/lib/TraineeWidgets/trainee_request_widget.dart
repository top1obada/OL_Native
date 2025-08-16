import 'package:flutter/material.dart';

import 'package:ol_driving_license_management_dto/TraineeDTO/TraineeRequestDTO.dart';

class WDUserRequestDetails extends StatelessWidget {
  const WDUserRequestDetails({super.key, required this.requestDTO, this.onTap});

  final ClsUserRequestDTO requestDTO;
  final Function(ClsUserRequestDTO?)? onTap;

  Color _getStatusColor(EnRequestState? state) {
    if (state == null) return Colors.grey;

    switch (state) {
      case EnRequestState.pending:
        return Colors.orange;
      case EnRequestState.completed:
        return Colors.green;
      case EnRequestState.canceled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(EnRequestState? state) {
    if (state == null) return '-';

    switch (state) {
      case EnRequestState.pending:
        return 'Pending';
      case EnRequestState.completed:
        return 'Completed';
      case EnRequestState.canceled:
        return 'Canceled';
      default:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(requestDTO.requestState);
    final statusText = _getStatusText(requestDTO.requestState);

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const Icon(Icons.assignment, color: Colors.blue),
          title: Text(
            "Request #${requestDTO.requestID ?? 'N/A'}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Type: ${requestDTO.requestName ?? '-'}",
                style: TextStyle(color: Colors.blueGrey[800]),
              ),
              Text(
                "Submitted: ${requestDTO.requestDate != null ? requestDTO.requestDate!.toLocal().toString().split(' ')[0] : '-'}",
                style: TextStyle(color: Colors.grey[800]),
              ),
              Text(
                "Processed: ${requestDTO.processedDate != null ? requestDTO.processedDate!.toLocal().toString().split(' ')[0] : 'Not processed'}",
                style: TextStyle(color: Colors.grey[800]),
              ),
              if (requestDTO.processedBy != null)
                Text(
                  "By: ${requestDTO.processedBy}",
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
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          onTap: () {
            onTap?.call(requestDTO);
          },
        ),
      ),
    );
  }
}
