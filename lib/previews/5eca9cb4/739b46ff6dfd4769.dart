import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/card.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkCard() {
  return UkCard(
    header: const Text('Card Header'),
    child: const Text(
      'This is the main content of the card. It can span multiple lines and showcase typical usage.',
    ),
    footer: const Text('Card Footer'),
  );
}
