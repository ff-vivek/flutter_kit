import 'package:flutter/material.dart';

enum UkSectionVariant { normal, muted, contrast }

/// Vertical section with generous spacing and optional background variant.
class UkSection extends StatelessWidget {
  const UkSection({
    super.key,
    this.variant = UkSectionVariant.normal,
    this.padding = const EdgeInsets.symmetric(vertical: 40),
    required this.child,
  });

  final UkSectionVariant variant;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = switch (variant) {
      UkSectionVariant.normal => Colors.transparent,
      UkSectionVariant.muted => cs.surfaceContainerHighest,
      UkSectionVariant.contrast => cs.primaryContainer,
    };

    return Container(
      color: bg,
      padding: padding,
      child: child,
    );
  }
}
