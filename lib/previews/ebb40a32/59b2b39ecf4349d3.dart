import 'package:flutter/material.dart';
import 'package:flutterkit/kit/layout/section.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkSection() {
  return UkSection(
    variant: UkSectionVariant.normal,
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: const Text(
      'Sample section content',
      style: TextStyle(fontSize: 16),
    ),
  );
}
