import 'package:flutter/material.dart';
import 'package:flutterkit/kit/elements/heading.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkHeading() {
  return const UkHeading(
    'Welcome to FlutterKit',
    level: 2,
    textAlign: TextAlign.center,
    // color left null to use default theme color
  );
}
