import 'package:flutter/material.dart';
import '../core/breakpoints.dart';

/// A responsive 12-column grid similar to UIkit's Grid.
class UkGrid extends StatelessWidget {
  const UkGrid({
    super.key,
    required this.children,
    this.gap = UkGridDefaults.gap,
    this.runSpacing,
    this.alignment = WrapAlignment.start,
  });

  final List<UkCol> children;
  final double gap;
  final double? runSpacing;
  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final bp = breakpointForWidth(width);

        return Wrap(
          alignment: alignment,
          spacing: gap,
          runSpacing: runSpacing ?? gap,
          children: children.map((col) {
            final span = col._spanFor(bp).clamp(1, UkGridDefaults.columns);
            final fraction = span / UkGridDefaults.columns;
            final itemWidth = (width * fraction) - gap;
            return ConstrainedBox(
              constraints: BoxConstraints(
                // Prevent negative widths on narrow screens
                minWidth: 0,
                maxWidth: itemWidth > 0 ? itemWidth : width,
              ),
              child: SizedBox(
                width: itemWidth > 0 ? itemWidth : width,
                child: col.child,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

/// Grid column with responsive spans. Defaults to full width on xs.
class UkCol extends StatelessWidget {
  const UkCol({
    super.key,
    this.xs = 12,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    required this.child,
  });

  final int xs;
  final int? sm;
  final int? md;
  final int? lg;
  final int? xl;
  final Widget child;

  int _spanFor(UkBreakpoint bp) {
    switch (bp) {
      case UkBreakpoint.xs:
        return xs;
      case UkBreakpoint.sm:
        return sm ?? xs;
      case UkBreakpoint.md:
        return md ?? sm ?? xs;
      case UkBreakpoint.lg:
        return lg ?? md ?? sm ?? xs;
      case UkBreakpoint.xl:
        return xl ?? lg ?? md ?? sm ?? xs;
    }
  }

  @override
  Widget build(BuildContext context) => child;
}
