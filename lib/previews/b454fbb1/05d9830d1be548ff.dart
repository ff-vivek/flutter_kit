import 'package:flutter/material.dart';
import 'package:flutterkit/kit/elements/list.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkListTile() {
  return UkListTile(
    leading: const Icon(Icons.account_circle),
    title: 'John Doe',
    subtitle: 'Software Engineer',
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      print('UkListTile tapped');
    },
  );
}
