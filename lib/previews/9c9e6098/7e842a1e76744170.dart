import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/modal.dart';

@Preview(name: 'Default', width: 300, height: 400)
Widget preview_showUkModalSheet() {
  return Builder(
    builder: (context) {
      // Show the modal sheet after the first frame is rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUkModalSheet(
          context,
          title: 'Sample Modal',
          child: const Text(
            'This is a preview of the UkModalSheet content.',
            style: TextStyle(fontSize: 16),
          ),
        );
      });
      // Return an empty placeholder widget
      return const SizedBox.shrink();
    },
  );
}
