import 'package:flutter/material.dart';
import 'package:flutterkit/kit/layout/grid.dart';

@Preview(name: 'Default', width: 300, height: 200)
Widget preview_UkGrid() {
  return UkGrid(
    children: [
      const UkCol(
        child: SizedBox(
          height: 80,
          child: ColoredBox(
            color: Colors.blueAccent,
            child: Center(child: Text('Column 1')),
          ),
        ),
      ),
      const UkCol(
        child: SizedBox(
          height: 80,
          child: ColoredBox(
            color: Colors.greenAccent,
            child: Center(child: Text('Column 2')),
          ),
        ),
      ),
    ],
    gap: 16.0,
    alignment: WrapAlignment.start,
  );
}
