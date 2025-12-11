import 'package:flutter/material.dart';
import 'package:flutterkit/kit/elements/table.dart';

@Preview(name: 'Default', width: 350, height: 250)
Widget preview_UkTable() {
  return UkTable(
    columns: ['Name', 'Age', 'City'],
    rows: [
      ['Alice', '30', 'New York'],
      ['Bob', '25', 'San Francisco'],
      ['Charlie', '28', 'Chicago'],
    ],
    striped: true,
    hover: true,
    dense: false,
    bordered: true,
  );
}
