import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_current_appoitement_dto.dart';

class WDCaseCurrentAppointment extends StatelessWidget {
  const WDCaseCurrentAppointment({
    super.key,
    required this.appointmentDTO,
    this.onTap,
  });

  final ClsCaseAppointmentDTO? appointmentDTO;
  final Function(ClsCaseAppointmentDTO?)? onTap;

  Color _getStatusColor() {
    if (appointmentDTO == null) return Colors.grey;

    final now = DateTime.now();
    final appointmentDate = appointmentDTO!.appointmentDate;

    if (appointmentDate == null) return Colors.grey;

    if (appointmentDate.isBefore(now)) {
      return Colors.orange; // Past appointment
    } else if (appointmentDate.isAfter(now)) {
      return Colors.green; // Upcoming appointment
    } else {
      return Colors.blue; // Current appointment
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final hasAppointment = appointmentDTO != null;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const Icon(Icons.calendar_today, color: Colors.blue),
          title: Text(
            hasAppointment
                ? "Appointment #${appointmentDTO!.appointmentID ?? 'N/A'}"
                : "No Current Appointment",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Test Type: ${hasAppointment ? appointmentDTO!.testTypeName ?? '-' : '-'}",
                style: TextStyle(color: Colors.blueGrey[800]),
              ),
              Text(
                "Date: ${hasAppointment && appointmentDTO!.appointmentDate != null ? appointmentDTO!.appointmentDate!.toLocal().toString().split(' ')[0] : '-'}",
                style: TextStyle(color: Colors.grey[800]),
              ),
              Text(
                "Time: ${hasAppointment && appointmentDTO!.appointmentDate != null ? appointmentDTO!.appointmentDate!.toLocal().toString().split(' ')[1].substring(0, 5) : '-'}",
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
                hasAppointment
                    ? (appointmentDTO!.appointmentDate?.isBefore(
                              DateTime.now(),
                            ) ??
                            false
                        ? "Past"
                        : "Upcoming")
                    : 'None',
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          onTap: () {
            onTap?.call(appointmentDTO);
          },
        ),
      ),
    );
  }
}
