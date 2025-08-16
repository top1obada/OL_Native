import 'package:flutter/material.dart';
import 'package:ol_driving_license_management_dto/LicensesDTOs/TraineeLicenseDTO.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/wrap_row_building.dart';

class WDTraineeLicenseDetailsRequest extends StatelessWidget {
  const WDTraineeLicenseDetailsRequest({
    super.key,
    required this.traineeLicenseDTO,
    this.onTap,
  });

  final ClsTraineeLicenseDTO traineeLicenseDTO;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double baseFontSize =
        screenWidth < 400
            ? 14
            : screenWidth < 600
            ? 16
            : 20;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with license type and status icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        traineeLicenseDTO.licenseTypeName ??
                            'Unknown License Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: baseFontSize + 2,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                    _buildLicenseStatusIcon(traineeLicenseDTO.expirationDate),
                  ],
                ),
                const SizedBox(height: 8),

                // License details
                BuildRowWrap(
                  label: 'Issued Date:',
                  value:
                      traineeLicenseDTO.issuedDate != null
                          ? _formatDate(traineeLicenseDTO.issuedDate!)
                          : 'N/A',
                  fontSize: baseFontSize,
                ),
                BuildRowWrap(
                  label: 'Expiration Date:',
                  value:
                      traineeLicenseDTO.expirationDate != null
                          ? _formatDate(traineeLicenseDTO.expirationDate!)
                          : 'N/A',
                  fontSize: baseFontSize,
                  valueColor: _getExpirationColor(
                    traineeLicenseDTO.expirationDate,
                  ),
                ),

                // Status text
                if (traineeLicenseDTO.expirationDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _getExpirationStatus(traineeLicenseDTO.expirationDate!),
                      style: TextStyle(
                        color: _getExpirationColor(
                          traineeLicenseDTO.expirationDate,
                        ),
                        fontSize: baseFontSize - 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
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
    if (expirationDate.isBefore(now)) return Colors.red;
    if (expirationDate.difference(now).inDays < 30) return Colors.orange;
    return Colors.green;
  }

  String _getExpirationStatus(DateTime expirationDate) {
    final now = DateTime.now();
    if (expirationDate.isBefore(now)) return 'EXPIRED';
    final daysLeft = expirationDate.difference(now).inDays;
    if (daysLeft < 30) return 'Expires in $daysLeft days';
    return 'Valid (${daysLeft} days remaining)';
  }

  Widget _buildLicenseStatusIcon(DateTime? expirationDate) {
    if (expirationDate == null) return Text("");
    final color = _getExpirationColor(expirationDate);
    return Icon(
      expirationDate.isAfter(DateTime.now())
          ? Icons.check_circle
          : Icons.warning,
      color: color,
      size: 28,
    );
  }
}
