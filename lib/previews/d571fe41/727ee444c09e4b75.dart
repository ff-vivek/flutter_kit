import 'package:flutter/widgets.dart';
import 'package:flutterkit/kit/components/navbar.dart';

@Preview(name: 'Default', width: 300, height: 60)
Widget preview_UkSubnav() {
  return UkSubnav(
    items: const ['Home', 'Features', 'Pricing', 'Contact'],
    selectedIndex: 0,
    onChanged: (int index) {
      print('UkSubnav selected: $index');
    },
    variant: UkSubnavVariant.underline,
    wrap: true,
  );
}
