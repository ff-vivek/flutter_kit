import 'package:flutter/material.dart';
import 'package:flutterkit/kit/forms/toggles.dart';

@Preview(name: 'Default', width: 200, height: 60)
Widget preview_UkSwitch() {
  return const UkSwitch(
    value: true,
    label: 'Enable notifications',
    subtitle: 'Receive updates',
    enabled: true,
    onChanged: _onSwitchChanged,
  );
}

// Simple callback implementation
void _onSwitchChanged(bool value) {
  // In a preview, just print the new value
  debugPrint('UkSwitch changed: $value');
}
