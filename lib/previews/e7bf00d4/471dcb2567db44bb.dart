import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/breadcrumb.dart';

@Preview(name: 'Default', width: 300, height: 80)
Widget preview_UkBreadcrumb() {
  return UkBreadcrumb(
    items: const [
      UkBreadcrumbItem(
        'Home',
        icon: Icons.home,
        onTap: null,
      ),
      UkBreadcrumbItem(
        'Category',
        icon: Icons.category,
        onTap: null,
      ),
      UkBreadcrumbItem(
        'Product',
        // No icon for the current item
        onTap: null,
      ),
    ],
    onItemTap: (int index, UkBreadcrumbItem item) {
      print('Breadcrumb tapped: \$index - \${item.label}');
    },
    // Use default separator by leaving it null
    separator: null,
  );
}
