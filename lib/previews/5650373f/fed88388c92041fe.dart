import 'package:flutter/material.dart';
import 'package:flutterkit/kit/forms/toggles.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkCheckbox() {
  return const UkCheckbox(
    value: false,
    label: 'Accept terms',
    subtitle: 'I agree to the privacy policy',
    enabled: true,
    onChanged: _onChanged,
  );
}

// Simple callback to satisfy the required signature
void _onChanged(bool? newValue) {
  // In a preview, just print the new value
  // ignore: avoid_print
  print('UkCheckbox changed: $newValue');
}
