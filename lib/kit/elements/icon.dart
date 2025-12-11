import 'package:flutter/material.dart';

/// Themed Icon wrapper to keep sizes and colors consistent across the kit.
///
/// Defaults to using the current theme's onSurface color. Prefer passing a
/// color from Theme.of(context).colorScheme when you need emphasis
/// (e.g., colorScheme.primary, error, onSurfaceVariant for muted, etc.).
class UkIcon extends StatelessWidget {
  const UkIcon(
    this.icon, {
    super.key,
    this.size = UkIconSize.medium,
    this.color,
    this.semanticLabel,
  });

  final IconData icon;
  final UkIconSize size;
  final Color? color;
  final String? semanticLabel;

  double get _px => switch (size) {
        UkIconSize.small => 16,
        UkIconSize.medium => 20,
        UkIconSize.large => 24,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Icon(
      icon,
      size: _px,
      color: color ?? cs.onSurface,
      semanticLabel: semanticLabel,
    );
  }
}

/// Preset icon sizes aligned with the kit's typography scale.
enum UkIconSize { small, medium, large }
