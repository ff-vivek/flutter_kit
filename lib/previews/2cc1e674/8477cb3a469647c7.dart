import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/alert.dart';

@Preview(name: 'Default', width: 300, height: 100)
Widget preview_UkAlert() {
  return UkAlert(
    message: 'Your changes have been saved successfully.',
    type: UkAlertType.success,
    dismissible: true,
    onDismissed: () {
      print('Alert dismissed');
    },
  );
}
