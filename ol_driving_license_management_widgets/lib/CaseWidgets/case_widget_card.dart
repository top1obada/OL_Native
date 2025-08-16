import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ol_driving_license_management_dto/CaseDTO/case_dto.dart';
import 'package:ol_driving_license_management_widgets/ColorsProviders/long_click_color_provider.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/wrap_row_building.dart';
import 'package:provider/provider.dart';

class WDCaseDetailsCard extends StatefulWidget {
  final ClsCaseDTO caseDTO;
  final Function(ClsCaseDTO)? onTab;

  const WDCaseDetailsCard({super.key, required this.caseDTO, this.onTab});

  @override
  State<WDCaseDetailsCard> createState() => _WDCaseDetailsStateCard();
}

class _WDCaseDetailsStateCard extends State<WDCaseDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final statusColor = _getStatusColor(widget.caseDTO.caseState);

    double baseFontSize =
        screenWidth < 400
            ? 14
            : screenWidth < 600
            ? 16
            : 20;

    final startedDate =
        widget.caseDTO.startedDate != null
            ? DateFormat('yyyy-MM-dd').format(widget.caseDTO.startedDate!)
            : 'N/A';

    final finishedDate =
        widget.caseDTO.finishedDate != null
            ? DateFormat('yyyy-MM-dd').format(widget.caseDTO.finishedDate!)
            : 'N/A';

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: ChangeNotifierProvider(
        create:
            (_) => PVLongClickColorProvider(
              onClickColor: Colors.blue[100]!,
              onEndClickColor: Theme.of(context).cardColor,
            ),
        child: Builder(
          builder: (subBuilderContext) {
            return GestureDetector(
              onTap:
                  widget.onTab != null
                      ? () => widget.onTab!(widget.caseDTO)
                      : null,
              onLongPressStart:
                  widget.onTab != null
                      ? (_) {
                        subBuilderContext
                            .read<PVLongClickColorProvider>()
                            .click();
                      }
                      : null,
              onLongPressEnd:
                  widget.onTab != null
                      ? (_) {
                        subBuilderContext
                            .read<PVLongClickColorProvider>()
                            .endClick();
                      }
                      : null,
              child: Consumer<PVLongClickColorProvider>(
                builder:
                    (context, value, child) => Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color:
                          widget.onTab == null
                              ? Theme.of(context).cardColor
                              : value.currentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BuildRowWrap(
                              label: 'Case ID:',
                              value: widget.caseDTO.caseID?.toString() ?? 'N/A',
                              fontSize: baseFontSize,
                              valueColor: Colors.blue[800],
                            ),
                            BuildRowWrap(
                              label: 'License Type:',
                              value: widget.caseDTO.licenseTypeName ?? 'N/A',
                              fontSize: baseFontSize,
                            ),
                            BuildRowWrap(
                              label: 'Started Date:',
                              value: startedDate,
                              fontSize: baseFontSize,
                            ),
                            BuildRowWrap(
                              label: 'Finished Date:',
                              value: finishedDate,
                              fontSize: baseFontSize,
                            ),
                            BuildRowWrap(
                              label: 'Status:',
                              value:
                                  widget.caseDTO.caseState?.toString() ?? 'N/A',
                              fontSize: baseFontSize,
                              valueColor: statusColor,
                            ),
                            BuildRowWrap(
                              label: 'Due Payment:',
                              value:
                                  widget.caseDTO.duePayment?.toStringAsFixed(
                                    2,
                                  ) ??
                                  '0.00',
                              fontSize: baseFontSize,
                            ),
                            BuildRowWrap(
                              label: 'Total Payments:',
                              value:
                                  widget.caseDTO.totalPayments?.toStringAsFixed(
                                    2,
                                  ) ??
                                  '0.00',
                              fontSize: baseFontSize,
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getStatusColor(EnCaseState? state) {
    if (state == null) return Colors.grey;

    switch (state) {
      case EnCaseState.eActive:
        return Colors.green[700]!;
      case EnCaseState.eCanceled:
        return Colors.red[700]!;
      case EnCaseState.eCompleted:
        return Colors.blue[700]!;
      default:
        return Colors.grey[700]!;
    }
  }
}
