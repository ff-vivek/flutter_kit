import 'package:flutter/material.dart';

/// Semantic heading supporting levels h1-h6.
class UkHeading extends StatelessWidget {
  const UkHeading(
    this.text, {
    super.key,
    this.level = 2,
    this.textAlign,
    this.color,
  }) : assert(level >= 1 && level <= 6, 'level must be 1..6');

  final String text;
  final int level;
  final TextAlign? textAlign;
  final Color? color;

  TextStyle _style(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return switch (level) {
      1 => tt.headlineLarge!,
      2 => tt.headlineMedium!,
      3 => tt.headlineSmall!,
      4 => tt.titleLarge!,
      5 => tt.titleMedium!,
      6 => tt.titleSmall!,
      _ => tt.titleLarge!,
    };
  }

  @override
  Widget build(BuildContext context) {
    final style = _style(context).copyWith(color: color);
    return Text(text, style: style, textAlign: textAlign);
  }
}
