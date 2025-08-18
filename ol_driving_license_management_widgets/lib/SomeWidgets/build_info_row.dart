import 'package:flutter/material.dart';

class BuildInfoRow extends StatelessWidget {
  const BuildInfoRow({super.key, required this.label, required this.value});

  final String label;

  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.grey[850],
            ),
          ),
          SizedBox(width: 5),
          Text(
            value ?? '-',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }
}
