import 'package:flutter/material.dart';
import 'package:flutterkit/kit/layout/container.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkContainer() {
  return const UkContainer(
    size: UkContainerSize.large,
    horizontalPadding: 16,
    child: Center(
      child: Text(
        'Hello, UkContainer!',
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}
