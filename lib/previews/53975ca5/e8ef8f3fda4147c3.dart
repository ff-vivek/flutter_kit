import 'package:flutter/material.dart';
import 'package:flutterkit/kit/elements/progress.dart';

@Preview(name: 'Default', width: 200, height: 20)
Widget preview_UkProgress() {
  return const UkProgress(
    value: 0.6,
    variant: UkProgressVariant.primary,
    size: UkProgressSize.medium,
    rounded: true,
  );
}
