import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/button.dart';

@Preview(name: 'Default', width: 200, height: 60)
Widget preview_UkButton() {
  return UkButton(
    label: 'Press Me',
    onPressed: () {
      print('UkButton pressed');
    },
    variant: UkButtonVariant.primary,
    size: UkButtonSize.medium,
  );
}
