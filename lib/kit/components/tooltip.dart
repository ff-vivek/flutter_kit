import 'package:flutter/material.dart';

/// Simple tooltip wrapper with modern styling.
class UkTooltip extends StatelessWidget {
  const UkTooltip({
    super.key,
    required this.message,
    required this.child,
    this.placement = UkTooltipPlacement.top,
    this.wait = const Duration(milliseconds: 400),
    this.show = const Duration(seconds: 3),
  });

  final String message;
  final Widget child;
  final UkTooltipPlacement placement;
  final Duration wait;
  final Duration show;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final preferBelow = switch (placement) {
      UkTooltipPlacement.top => false,
      UkTooltipPlacement.bottom => true,
    };

    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      waitDuration: wait,
      showDuration: show,
      decoration: BoxDecoration(
        color: cs.inversePrimary.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.onSurfaceVariant.withValues(alpha: 0.12)),
      ),
      textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: cs.onPrimaryContainer),
      child: child,
    );
  }
}

enum UkTooltipPlacement { top, bottom }
