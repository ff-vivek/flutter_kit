import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/accordion.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkAccordion() {
  return UkAccordion(
    items: [
      UkAccordionItem(
        title: 'First Item',
        content: const Text('Content of the first accordion item.'),
        leading: const Icon(Icons.info_outline),
        initiallyExpanded: false,
      ),
      UkAccordionItem(
        title: 'Second Item',
        content: const Text('Content of the second accordion item.'),
        leading: const Icon(Icons.settings),
        initiallyExpanded: true,
      ),
    ],
    allowMultiple: true,
    border: true,
  );
}
