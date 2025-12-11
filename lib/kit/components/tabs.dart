import 'package:flutter/material.dart';

/// Simple Tabs with modern tab bar and intrinsic-height content
class UkTabs extends StatefulWidget {
  const UkTabs({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
    this.expand = false,
  }) : assert(tabs.length == children.length, 'tabs and children must have same length');

  final List<String> tabs;
  final List<Widget> children;
  final int initialIndex;
  final bool expand;

  @override
  State<UkTabs> createState() => _UkTabsState();
}

class _UkTabsState extends State<UkTabs> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabs.length, vsync: this, initialIndex: widget.initialIndex);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final tabBar = TabBar(
      controller: _controller,
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      labelColor: cs.primary,
      unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
      indicatorColor: cs.primary,
      dividerColor: cs.outline.withValues(alpha: 0.12),
      tabs: [for (final t in widget.tabs) Text(t, overflow: TextOverflow.ellipsis)],
    );

    final body = widget.expand
        ? Expanded(
            child: TabBarView(
              controller: _controller,
              children: widget.children,
            ),
          )
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeOutCubic,
            child: KeyedSubtree(
              key: ValueKey(_controller.index),
              child: widget.children[_controller.index],
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [tabBar, const SizedBox(height: 12), body],
    );
  }
}
