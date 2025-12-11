import 'package:flutter/material.dart';
import 'package:flutterkit/kit/forms/input.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkTextField() {
  return const UkTextField(
    label: 'Username',
    hint: 'Enter your username',
    helperText: 'Your unique identifier',
    prefixIcon: Icons.person,
    suffixIcon: Icons.check_circle,
    size: UkFieldSize.medium,
    isPassword: false,
    enabled: true,
  );
}
