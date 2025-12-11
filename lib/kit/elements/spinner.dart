import 'package:flutter/material.dart';

/// Circular activity indicator with sizes and variants.
class UkSpinner extends StatelessWidget {
  const UkSpinner({
    super.key,
    this.size = UkSpinnerSize.medium,
    this.variant = UkSpinnerVariant.primary,
    this.strokeWidth,
    this.semanticLabel,
  });

  final UkSpinnerSize size;
  final UkSpinnerVariant variant;
  final double? strokeWidth;
  final String? semanticLabel;

  double get _dimension => switch (size) {
        UkSpinnerSize.small => 16,
        UkSpinnerSize.medium => 20,
        UkSpinnerSize.large => 28,
      };

  double get _stroke => strokeWidth ?? switch (size) {
        UkSpinnerSize.small => 2,
        UkSpinnerSize.medium => 2.5,
        UkSpinnerSize.large => 3,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = switch (variant) {
      UkSpinnerVariant.primary => cs.primary,
      UkSpinnerVariant.secondary => cs.secondary,
      UkSpinnerVariant.success => cs.tertiary,
      UkSpinnerVariant.warning => cs.secondaryContainer,
      UkSpinnerVariant.danger => cs.error,
      UkSpinnerVariant.neutral => cs.onSurfaceVariant,
    };

    return Semantics(
      label: semanticLabel,
      child: SizedBox(
        width: _dimension,
        height: _dimension,
        child: CircularProgressIndicator(
          strokeWidth: _stroke,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}

enum UkSpinnerSize { small, medium, large }
enum UkSpinnerVariant { primary, secondary, success, warning, danger, neutral }
