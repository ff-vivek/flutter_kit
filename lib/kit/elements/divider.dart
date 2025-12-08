import 'package:flutter/material.dart';

/// Thin divider using theme outline color.
class UkDivider extends StatelessWidget {
  const UkDivider({super.key, this.thickness = 0.75, this.margin});

  final double thickness;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outline.withValues(alpha: 0.2);
    final line = Container(height: thickness, color: color);
    if (margin == null) return line;
    return Padding(padding: margin!, child: line);
  }
}
