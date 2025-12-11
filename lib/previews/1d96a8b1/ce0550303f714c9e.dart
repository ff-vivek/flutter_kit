import 'package:flutter/material.dart';
import 'package:flutterkit/kit/forms/input.dart';

@Preview(name: 'Default', width: 300, height: 120)
Widget preview_UkTextArea() {
  return const UkTextArea(
    label: 'Description',
    hint: 'Enter detailed information here',
    helperText: 'You can write up to 200 characters.',
    prefixIcon: Icons.description,
    suffixIcon: Icons.check_circle,
    size: UkFieldSize.medium,
    enabled: true,
    minLines: 3,
    maxLines: 6,
    onChanged: _printChanged,
  );
}

// Simple callback to satisfy the required signature
void _printChanged(String value) {
  // ignore: avoid_print
  print('UkTextArea changed: $value');
}
