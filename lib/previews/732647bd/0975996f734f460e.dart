import 'package:flutter/material.dart';
import 'package:flutterkit/kit/forms/toggles.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkRadio() {
  return UkRadio<String>(
    value: 'option1',
    groupValue: 'option1',
    onChanged: (String? newValue) {
      print('Radio changed: $newValue');
    },
    label: 'Option 1',
    subtitle: 'Select this option',
    enabled: true,
  );
}
