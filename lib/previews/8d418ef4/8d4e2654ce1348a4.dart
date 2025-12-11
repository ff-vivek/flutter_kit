import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/tooltip.dart';

@Preview(name: 'Default', width: 200, height: 100)
Widget preview_UkTooltip() {
  return UkTooltip(
    message: 'This is a helpful tooltip',
    child: const Icon(Icons.info_outline, size: 24),
    // optional parameters using defaults
    placement: UkTooltipPlacement.top,
    wait: const Duration(milliseconds: 400),
    show: const Duration(seconds: 3),
  );
}
