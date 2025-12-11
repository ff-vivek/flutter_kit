import 'package:flutter/material.dart';

class UkFilterItem {
  const UkFilterItem({required this.child, this.tags = const {}});
  final Widget child;
  final Set<String> tags; // e.g., {'ui', 'data'}
}

/// UkFilterGrid
/// Shows items in a responsive grid and filters them by a single tag.
class UkFilterGrid extends StatelessWidget {
  const UkFilterGrid({
    super.key,
    required this.items,
    this.activeTag,
    this.gap = 12,
    this.crossAxisCountMd = 3,
  });

  final List<UkFilterItem> items;
  final String? activeTag; // null or 'all' = show everything
  final double gap;
  final int crossAxisCountMd;

  @override
  Widget build(BuildContext context) {
    final filtered = (activeTag == null || activeTag == 'all')
        ? items
        : items.where((e) => e.tags.contains(activeTag)).toList();

    // Responsive columns: xs=1, sm=2, md=crossAxisCountMd
    final width = MediaQuery.of(context).size.width;
    int cols = 1;
    if (width >= 640) cols = 2; // sm
    if (width >= 960) cols = crossAxisCountMd; // md+

    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          crossAxisSpacing: gap,
          mainAxisSpacing: gap,
          childAspectRatio: 4 / 3,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, i) {
          return _AnimatedFilterChild(child: filtered[i].child);
        },
      );
    });
  }
}

class _AnimatedFilterChild extends StatefulWidget {
  const _AnimatedFilterChild({required this.child});
  final Widget child;

  @override
  State<_AnimatedFilterChild> createState() => _AnimatedFilterChildState();
}

class _AnimatedFilterChildState extends State<_AnimatedFilterChild> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 240));
  late final Animation<double> _opacity = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
  late final Animation<double> _scale = Tween(begin: 0.98, end: 1.0).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
