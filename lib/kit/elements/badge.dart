import 'package:flutter/material.dart';

enum UkBadgeVariant { primary, secondary, tertiary, neutral }

/// Minimal, pill-shaped badge.
class UkBadge extends StatelessWidget {
  const UkBadge(
    this.label, {
    super.key,
    this.variant = UkBadgeVariant.primary,
  });

  final String label;
  final UkBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (bg, fg) = switch (variant) {
      UkBadgeVariant.primary => (cs.primary, cs.onPrimary),
      UkBadgeVariant.secondary => (cs.secondary, cs.onSecondary),
      UkBadgeVariant.tertiary => (cs.tertiary, cs.onTertiary),
      UkBadgeVariant.neutral => (cs.surfaceContainerHighest, cs.onSurface),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg),
      ),
    );
  }
}
