import 'package:flutter/material.dart';
import 'package:flutterkit/kit/layout/grid.dart';

@Preview(name: 'Default', width: 200, height: 100)
Widget preview_UkCol() {
  return UkCol(
    xs: 12,
    child: Container(
      color: Colors.blueAccent,
      alignment: Alignment.center,
      child: const Text(
        'Column Content',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
