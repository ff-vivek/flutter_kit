import 'package:flutter/material.dart';
import 'package:flutterkit/kit/forms/select.dart';
import 'package:flutterkit/kit/forms/input.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkSelect() {
  return UkSelect<String>(
    options: const [
      UkOption('Apple', 'apple', icon: Icons.apple),
      UkOption('Banana', 'banana', icon: Icons.food_bank),
      UkOption('Cherry', 'cherry'),
    ],
    value: 'banana',
    onChanged: (String? newValue) {
      print('Selected: $newValue');
    },
    label: 'Fruit',
    hint: 'Select a fruit',
    helperText: 'Choose one from the list',
    size: UkFieldSize.medium,
    enabled: true,
    validator: (String? val) {
      if (val == null || val.isEmpty) {
        return 'Please select a fruit';
      }
      return null;
    },
  );
}
