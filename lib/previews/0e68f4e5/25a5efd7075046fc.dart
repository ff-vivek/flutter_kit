import 'package:flutter/material.dart';
import 'package:flutterkit/kit/elements/icon.dart';

@Preview(name: 'Default', width: 40, height: 40)
Widget preview_UkIcon() {
  return const UkIcon(
    Icons.home,
    size: UkIconSize.medium,
    semanticLabel: 'Home icon',
  );
}
