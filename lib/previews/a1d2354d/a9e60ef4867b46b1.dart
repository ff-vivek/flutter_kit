import 'package:flutter/material.dart';
import 'package:flutterkit/kit/forms/slider.dart';

@Preview(name: 'Default', width: 300, height: 100)
Widget preview_UkSlider() {
  return UkSlider(
    value: 50.0,
    onChanged: (double newValue) {
      print('Slider changed to $newValue');
    },
    min: 0.0,
    max: 100.0,
    divisions: 5,
    label: '50',
  );
}
