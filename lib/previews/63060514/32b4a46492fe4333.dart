import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/sticky.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkSticky() {
  return UkSticky(
    minHeight: 56,
    maxHeight: 80,
    builder: (context, shrinkOffset, overlapsContent) {
      final t = (shrinkOffset / (80 - 56)).clamp(0.0, 1.0);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleMedium!,
          child: Opacity(
            opacity: 1 - 0.2 * t,
            child: const Text('Sticky Header'),
          ),
        ),
      );
    },
  );
}
