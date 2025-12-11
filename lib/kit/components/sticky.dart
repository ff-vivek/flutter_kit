import 'package:flutter/material.dart';

/// UkSticky — Sliver-based sticky header similar to UIkit's Sticky component.
///
/// Usage:
///   CustomScrollView(
///     slivers: [
///       UkSticky(
///         minHeight: 56,
///         maxHeight: 80,
///         builder: (context, shrinkOffset, overlapsContent) {
///           final t = (shrinkOffset / (80 - 56)).clamp(0.0, 1.0);
///           return Container(
///             color: Theme.of(context).colorScheme.surface,
///             padding: const EdgeInsets.symmetric(horizontal: 16),
///             alignment: Alignment.centerLeft,
///             child: DefaultTextStyle(
///               style: Theme.of(context).textTheme.titleMedium!,
///               child: Opacity(
///                 opacity: 1 - 0.2 * t,
///                 child: const Text('Sticky Header'),
///               ),
///             ),
///           );
///         },
///       ),
///       SliverList(...)
///     ],
///   )
class UkSticky extends StatelessWidget {
  const UkSticky({
    super.key,
    this.minHeight = 56,
    this.maxHeight = 72,
    required this.builder,
  });

  /// Minimum height when pinned.
  final double minHeight;

  /// Maximum height before shrinking.
  final double maxHeight;

  /// Builder for the sticky content. Receives current shrinkOffset and overlap.
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _UkStickyHeaderDelegate(
        minExtentValue: minHeight,
        maxExtentValue: maxHeight,
        builder: builder,
      ),
    );
  }
}

class _UkStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _UkStickyHeaderDelegate({
    required this.minExtentValue,
    required this.maxExtentValue,
    required this.builder,
  });

  final double minExtentValue;
  final double maxExtentValue;
  final Widget Function(BuildContext, double, bool) builder;

  @override
  double get minExtent => minExtentValue;

  @override
  double get maxExtent => maxExtentValue > minExtentValue ? maxExtentValue : minExtentValue;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      // Use surface color to blend with theme; avoid hard-coded colors.
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      child: builder(context, shrinkOffset, overlapsContent),
    );
  }

  @override
  bool shouldRebuild(covariant _UkStickyHeaderDelegate oldDelegate) {
    return oldDelegate.minExtentValue != minExtentValue ||
        oldDelegate.maxExtentValue != maxExtentValue ||
        oldDelegate.builder != builder;
  }
}
