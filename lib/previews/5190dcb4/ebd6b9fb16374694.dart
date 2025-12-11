import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/navbar.dart';

@Preview(name: 'Default', width: 360, height: 80)
Widget preview_UkNavbar() {
  return UkNavbar(
    title: 'My App',
    leading: IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        print('Menu pressed');
      },
    ),
    items: [
      UkNavbarItem('Home', icon: Icons.home),
      UkNavbarItem('Profile', icon: Icons.person),
      UkNavbarItem('Settings', icon: Icons.settings),
    ],
    selectedIndex: 0,
    onItemSelected: (int index) {
      print('Selected index: $index');
    },
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          print('Search pressed');
        },
      ),
      IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {
          print('Notifications pressed');
        },
      ),
    ],
    dense: false,
  );
}
