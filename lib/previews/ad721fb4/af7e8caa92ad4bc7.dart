import 'package:flutter/material.dart';
import 'package:flutterkit/kit/components/carousel.dart';

@Preview(name: 'Default', width: 300, height: 250)
Widget preview_UkCarousel() {
  return UkCarousel(
    items: [
      Container(color: Colors.redAccent),
      Container(color: Colors.greenAccent),
      Container(color: Colors.blueAccent),
    ],
    height: 200,
    autoPlay: true,
    interval: const Duration(seconds: 4),
    viewportFraction: 1.0,
    showDots: true,
  );
}
