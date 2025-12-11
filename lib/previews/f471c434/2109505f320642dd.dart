import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/tabs.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkTabs() {
  return UkTabs(
    tabs: ['Home', 'Profile', 'Settings'],
    children: const [
      Center(child: Text('Home Content')),
      Center(child: Text('Profile Content')),
      Center(child: Text('Settings Content')),
    ],
    initialIndex: 0,
    expand: false,
  );
}
