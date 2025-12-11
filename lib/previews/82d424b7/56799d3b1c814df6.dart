import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/offcanvas.dart';

@Preview(name: 'Default')
Widget preview_showUkOffcanvas() {
  return Builder(
    builder: (context) {
      // Show the offcanvas after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUkOffcanvas(
          context,
          child: const Text('Offcanvas content goes here.'),
          side: UkOffcanvasSide.left,
          // width omitted to use default calculation
          title: 'Sample Menu',
        );
      });
      // The preview itself can be an empty container
      return const SizedBox.shrink();
    },
  );
}
