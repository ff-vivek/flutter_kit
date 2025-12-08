import 'package:flutter/material.dart';

/// Container sizes emulate UIkit's container widths.
enum UkContainerSize { small, medium, large, xlarge, fluid }

/// UkContainer centers content and applies a maxWidth with horizontal padding.
class UkContainer extends StatelessWidget {
  const UkContainer({
    super.key,
    this.size = UkContainerSize.large,
    this.horizontalPadding = 16,
    required this.child,
  });

  final UkContainerSize size;
  final double horizontalPadding;
  final Widget child;

  double? get _maxWidth {
    switch (size) {
      case UkContainerSize.small:
        return 640;
      case UkContainerSize.medium:
        return 960;
      case UkContainerSize.large:
        return 1200;
      case UkContainerSize.xlarge:
        return 1440;
      case UkContainerSize.fluid:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: child,
    );

    if (_maxWidth == null) return content;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: _maxWidth!),
        child: content,
      ),
    );
  }
}
