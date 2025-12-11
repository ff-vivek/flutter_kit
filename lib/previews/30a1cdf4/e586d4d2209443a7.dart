import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/scrollspy.dart';

@Preview(name: 'Default', width: 300, height: 100)
Widget preview_UkScrollspy() {
  return UkScrollspy(
    child: const Text(
      'Animated on scroll',
      style: TextStyle(fontSize: 18),
    ),
    // Using the widget's default values for realistic behavior
    curve: Curves.easeOutCubic,
    duration: const Duration(milliseconds: 500),
    delay: Duration.zero,
    offset: const Offset(0, 24),
    fade: true,
    threshold: 0.15,
  );
}
