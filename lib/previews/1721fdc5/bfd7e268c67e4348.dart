import 'package:flutter/material.dart';
import 'package:flutterkit/kit/elements/list.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkList() {
  return UkList(
    items: [
      UkListItemData(
        'First Item',
        subtitle: 'Subtitle 1',
        leading: const Icon(Icons.star),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          print('First item tapped');
        },
      ),
      UkListItemData(
        'Second Item',
        subtitle: 'Subtitle 2',
        leading: const Icon(Icons.favorite),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          print('Second item tapped');
        },
      ),
    ],
    variant: UkListVariant.plain,
  );
}
