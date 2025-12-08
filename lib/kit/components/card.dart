import 'package:flutter/material.dart';

/// Simple card with optional header and footer areas.
class UkCard extends StatelessWidget {
  const UkCard({
    super.key,
    this.header,
    required this.child,
    this.footer,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget? header;
  final Widget child;
  final Widget? footer;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.titleMedium!,
                child: header!,
              ),
            ),
          Padding(padding: padding, child: child),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: footer!,
            ),
        ],
      ),
    );
  }
}
