import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ol_driving_license_management_dto/RequestsDTO/base_Request_dto.dart';
import 'package:ol_driving_license_management_widgets/ColorsProviders/long_click_color_provider.dart';
import 'package:ol_driving_license_management_widgets/SomeWidgets/wrap_row_building.dart';
import 'package:provider/provider.dart';

class WDShowRequestInfoCard extends StatefulWidget {
  final ClsRequestDTO requestDTO;
  final String requestApplicantName;

  final Function(ClsRequestDTO)? onTap;

  const WDShowRequestInfoCard({
    super.key,
    required this.requestDTO,
    required this.requestApplicantName,
    this.onTap,
  });

  @override
  State<WDShowRequestInfoCard> createState() => _WDShowRequestInfoCardState();
}

class _WDShowRequestInfoCardState extends State<WDShowRequestInfoCard> {
  bool isLongPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double baseFontSize =
        screenWidth < 400
            ? 14
            : screenWidth < 600
            ? 16
            : 20;

    final formattedDate =
        widget.requestDTO.requestDate != null
            ? DateFormat('yyyy-MM-dd').format(widget.requestDTO.requestDate!)
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
                  widget.onTap != null
                      ? () => widget.onTap!(widget.requestDTO)
                      : null,
              onLongPressStart:
                  widget.onTap != null
                      ? (_) {
                        subBuilderContext
                            .read<PVLongClickColorProvider>()
                            .click();
                      }
                      : null,
              onLongPressEnd:
                  widget.onTap != null
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
                          widget.onTap == null
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
                              label: 'Applicant Name:',
                              value: widget.requestApplicantName,
                              fontSize: baseFontSize,
                              valueColor: Colors.blue[800],
                            ),
                            BuildRowWrap(
                              label: 'Request ID:',
                              value:
                                  widget.requestDTO.requestID?.toString() ??
                                  'N/A',
                              fontSize: baseFontSize,
                            ),
                            BuildRowWrap(
                              label: 'Request Date:',
                              value: formattedDate,
                              fontSize: baseFontSize,
                            ),
                            BuildRowWrap(
                              label: 'Request State:',
                              value:
                                  widget.requestDTO.requestState?.toString() ??
                                  'N/A',
                              fontSize: baseFontSize,
                              valueColor: _getStateColor(
                                widget.requestDTO.requestState,
                              ),
                            ),
                            BuildRowWrap(
                              label: 'Request Type:',
                              value:
                                  widget.requestDTO.requestType?.toString() ??
                                  'N/A',
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

  Color _getStateColor(EnRequestState? state) {
    switch (state) {
      case EnRequestState.ePending:
        return Colors.amber[800]!;
      case EnRequestState.eRejected:
        return Colors.red[700]!;
      case EnRequestState.eAccepted:
        return Colors.green[700]!;
      default:
        return Colors.grey[700]!;
    }
  }
}
