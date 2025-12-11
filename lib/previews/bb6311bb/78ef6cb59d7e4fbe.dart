import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/modal.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkModalSheet() {
  return UkModalSheet(
    title: 'Sample Modal',
    child: const Text(
      'This is the content of the modal sheet.',
      style: TextStyle(fontSize: 16),
    ),
  );
}
