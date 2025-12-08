import 'package:flutter/material.dart';

/// Responsive breakpoints for a 12-column grid system.
/// Values are inspired by common web breakpoints and UIkit philosophy.
enum UkBreakpoint { xs, sm, md, lg, xl }

class UkBreakpoints {
  static const double sm = 640;
  static const double md = 768;
  static const double lg = 1024;
  static const double xl = 1280;
}

/// Returns the current breakpoint for the given width.
UkBreakpoint breakpointForWidth(double width) {
  if (width >= UkBreakpoints.xl) return UkBreakpoint.xl;
  if (width >= UkBreakpoints.lg) return UkBreakpoint.lg;
  if (width >= UkBreakpoints.md) return UkBreakpoint.md;
  if (width >= UkBreakpoints.sm) return UkBreakpoint.sm;
  return UkBreakpoint.xs;
}

extension MediaQueryBreakpoints on BuildContext {
  Size get mediaSize => MediaQuery.sizeOf(this);
  double get mediaWidth => mediaSize.width;
  UkBreakpoint get breakpoint => breakpointForWidth(mediaWidth);

  bool get isXs => breakpoint == UkBreakpoint.xs;
  bool get isSm => breakpoint == UkBreakpoint.sm;
  bool get isMd => breakpoint == UkBreakpoint.md;
  bool get isLg => breakpoint == UkBreakpoint.lg;
  bool get isXl => breakpoint == UkBreakpoint.xl;

  bool atLeast(UkBreakpoint bp) {
    final current = breakpoint.index;
    return current >= bp.index;
  }
}

/// Grid defaults
class UkGridDefaults {
  static const int columns = 12;
  static const double gap = 16; // spacing between items
}
