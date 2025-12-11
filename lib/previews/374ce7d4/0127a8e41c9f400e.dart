import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/dropdown.dart';

@Preview(name: 'Default', width: 200, height: 80)
Widget preview_UkDropdown() {
  return UkDropdown(
    trigger: const Text('Open menu'),
    items: [
      UkDropdownItem(
        'Profile',
        icon: Icons.person,
        shortcut: '⌘P',
        onSelected: () {
          print('Profile selected');
        },
      ),
      UkDropdownItem(
        'Logout',
        icon: Icons.logout,
        destructive: true,
        onSelected: () {
          print('Logout selected');
        },
      ),
    ],
    // Using default alignmentOffset and closeOnSelect
  );
}
