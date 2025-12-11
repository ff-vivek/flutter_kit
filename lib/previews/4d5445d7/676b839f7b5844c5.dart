import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/lightbox.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_showUkLightbox() {
  return Builder(
    builder: (context) {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            showUkLightbox(
              context,
              images: [
                const NetworkImage(
                    'https://via.placeholder.com/600x400.png?text=Image+1'),
                const NetworkImage(
                    'https://via.placeholder.com/600x400.png?text=Image+2'),
                const NetworkImage(
                    'https://via.placeholder.com/600x400.png?text=Image+3'),
              ],
              initialIndex: 0,
              title: 'Sample Lightbox',
            );
          },
          child: const Text('Open Lightbox'),
        ),
      );
    },
  );
}
