import 'package:flutter/material.dart';

class BuildRowWrap extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;
  final Color labelColor;
  final Color? valueColor;

  const BuildRowWrap({
    super.key,
    required this.label,
    required this.value,
    required this.fontSize,
    this.labelColor = Colors.blueGrey,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          direction: Axis.horizontal,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: labelColor,
                fontSize: fontSize,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.teal[800],
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
