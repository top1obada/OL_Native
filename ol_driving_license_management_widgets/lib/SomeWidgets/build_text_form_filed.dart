import 'package:flutter/material.dart';

class BuildTextFormFiled extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const BuildTextFormFiled({
    super.key,
    required this.label,
    this.initialValue,
    this.enabled = true,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      controller: controller,
      initialValue: controller == null ? initialValue : null,
    );
  }
}
