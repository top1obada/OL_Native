import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/LicensesDTOs/TraineeLicenseDTO.dart';
import 'package:ol_driving_license_management_widgets/CaseWidgets/show_cases_widget.dart';

class WDTraineeLicenseDetails extends StatelessWidget {
  const WDTraineeLicenseDetails({
    super.key,
    required this.traineeLicenseDTO,
    this.onTap,
  });

  final ClsTraineeLicenseDTO traineeLicenseDTO;
  final IntCallBack? onTap;

  @override
  Widget build(BuildContext context) {
    final isInternational = traineeLicenseDTO.isInternationalLicense ?? false;
    final theme = Theme.of(context);

    return Card(
      color:
          isInternational
              ? Colors.blue[50]
              : theme.cardTheme.color ?? Colors.white,
      elevation: isInternational ? 4 : 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isInternational ? Colors.blue.shade200 : theme.dividerColor,
          width: isInternational ? 1.5 : 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onTap?.call(traineeLicenseDTO.licenseID!),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Leading Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      isInternational
                          ? const Color(0x3378B3F8) // Blue with 20% opacity
                          : const Color(0x1A000000), // Black with 10% opacity
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isInternational ? Icons.public : Icons.drive_eta,
                  color:
                      isInternational
                          ? Colors.blue[700]
                          : theme.iconTheme.color,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              // Main Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            traineeLicenseDTO.licenseTypeName ??
                                'Unknown License Type',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  isInternational
                                      ? Colors.blue[800]
                                      : theme.textTheme.titleMedium?.color,
                            ),
                          ),
                        ),
                        if (isInternational)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'INTERNATIONAL',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Dates
                    Text(
                      "Issued: ${traineeLicenseDTO.issuedDate != null ? _formatDate(traineeLicenseDTO.issuedDate!) : 'N/A'}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            isInternational
                                ? Colors.blue[600]
                                : Colors.grey[600],
                      ),
                    ),

                    const SizedBox(height: 2),

                    // Expiration Row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Expires: ${traineeLicenseDTO.expirationDate != null ? _formatDate(traineeLicenseDTO.expirationDate!) : 'N/A'}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: _getExpirationColor(
                                traineeLicenseDTO.expirationDate,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (traineeLicenseDTO.expirationDate != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getExpirationBackgroundColor(
                                traineeLicenseDTO.expirationDate,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _getExpirationStatus(
                                traineeLicenseDTO.expirationDate!,
                              ),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: _getExpirationColor(
                                  traineeLicenseDTO.expirationDate,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Trailing Icon
              if (traineeLicenseDTO.expirationDate != null)
                _buildLicenseStatusIcon(traineeLicenseDTO.expirationDate!),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color? _getExpirationColor(DateTime? expirationDate) {
    if (expirationDate == null) return Colors.grey;
    final now = DateTime.now();
    if (expirationDate.isBefore(now)) return Colors.red[600];
    if (expirationDate.difference(now).inDays < 30) return Colors.orange[600];
    return Colors.green[600];
  }

  Color _getExpirationBackgroundColor(DateTime? expirationDate) {
    final color = _getExpirationColor(expirationDate);
    if (color == Colors.red[600])
      return const Color(0x33FF5252); // Red with 20% opacity
    if (color == Colors.orange[600])
      return const Color(0x33FF9800); // Orange with 20% opacity
    return const Color(0x334CAF50); // Green with 20% opacity
  }

  String _getExpirationStatus(DateTime expirationDate) {
    final now = DateTime.now();
    if (expirationDate.isBefore(now)) return 'EXPIRED';
    final daysLeft = expirationDate.difference(now).inDays;
    if (daysLeft < 30) return '$daysLeft DAYS';
    return 'VALID';
  }

  Widget _buildLicenseStatusIcon(DateTime expirationDate) {
    final color = _getExpirationColor(expirationDate);
    return Icon(
      expirationDate.isAfter(DateTime.now())
          ? Icons.check_circle_outline
          : Icons.error_outline,
      color: color,
      size: 24,
    );
  }
}
