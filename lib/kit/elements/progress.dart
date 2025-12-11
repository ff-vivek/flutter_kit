import 'package:flutter/material.dart';

/// Linear progress bar with themed variants and sizes.
class UkProgress extends StatelessWidget {
  const UkProgress({
    super.key,
    this.value, // 0.0 - 1.0 for determinate; null for indeterminate shimmer
    this.variant = UkProgressVariant.primary,
    this.size = UkProgressSize.medium,
    this.rounded = true,
  });

  /// Current progress (0.0 - 1.0). Null shows an indeterminate bar.
  final double? value;

  /// Color/style variant.
  final UkProgressVariant variant;

  /// Height preset.
  final UkProgressSize size;

  /// Whether to use rounded corners.
  final bool rounded;

  double get _height => switch (size) {
        UkProgressSize.small => 6,
        UkProgressSize.medium => 8,
        UkProgressSize.large => 12,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final Color track = cs.onSurfaceVariant.withValues(alpha: 0.18);
    final Color bar = switch (variant) {
      UkProgressVariant.primary => cs.primary,
      UkProgressVariant.secondary => cs.secondary,
      UkProgressVariant.success => cs.tertiary,
      UkProgressVariant.warning => cs.secondaryContainer,
      UkProgressVariant.danger => cs.error,
      UkProgressVariant.neutral => cs.onSurfaceVariant,
    };

    final borderRadius = rounded ? BorderRadius.circular(999) : BorderRadius.circular(2);

    if (value == null) {
      // Indeterminate using a clipped LinearProgressIndicator for theme consistency
      return ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          height: _height,
          child: LinearProgressIndicator(
            backgroundColor: track,
            color: bar,
            minHeight: _height,
          ),
        ),
      );
    }

    final double clamped = value!.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: borderRadius,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth.isFinite ? constraints.maxWidth : double.infinity;
          // Use an AnimatedContainer to smoothly animate value changes
          return Container(
            height: _height,
            decoration: BoxDecoration(color: track),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                width: width.isFinite ? width * clamped : null,
                constraints: width.isFinite ? null : BoxConstraints.tightForFinite(width: clamped * 200),
                decoration: BoxDecoration(color: bar),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum UkProgressVariant { primary, secondary, success, warning, danger, neutral }

enum UkProgressSize { small, medium, large }
