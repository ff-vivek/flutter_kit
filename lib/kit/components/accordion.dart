import 'package:flutter/material.dart';

/// A single accordion item model
class UkAccordionItem {
  UkAccordionItem({
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.leading,
  });

  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final Widget? leading;
}

/// Accordion with modern, no-ripple expand/collapse animations
class UkAccordion extends StatefulWidget {
  const UkAccordion({
    super.key,
    required this.items,
    this.allowMultiple = true,
    this.border = true,
  });

  final List<UkAccordionItem> items;
  final bool allowMultiple;
  final bool border;

  @override
  State<UkAccordion> createState() => _UkAccordionState();
}

class _UkAccordionState extends State<UkAccordion> with TickerProviderStateMixin {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.items.map((e) => e.initiallyExpanded).toList(growable: false);
  }

  void _toggle(int index) {
    setState(() {
      if (widget.allowMultiple) {
        _expanded[index] = !_expanded[index];
      } else {
        for (var i = 0; i < _expanded.length; i++) {
          _expanded[i] = i == index ? !_expanded[i] : false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final borderColor = cs.outline.withValues(alpha: 0.18);

    return Column(
      children: [
        for (int i = 0; i < widget.items.length; i++)
          _AccordionTile(
            key: ValueKey('uk-accordion-item-$i'),
            item: widget.items[i],
            expanded: _expanded[i],
            onTap: () => _toggle(i),
            showDivider: widget.border && i < widget.items.length - 1,
            borderColor: borderColor,
          ),
      ],
    );
  }
}

class _AccordionTile extends StatelessWidget {
  const _AccordionTile({
    super.key,
    required this.item,
    required this.expanded,
    required this.onTap,
    required this.showDivider,
    required this.borderColor,
  });

  final UkAccordionItem item;
  final bool expanded;
  final VoidCallback onTap;
  final bool showDivider;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  if (item.leading != null) ...[
                    item.leading!,
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: Icon(Icons.keyboard_arrow_down, color: cs.onSurface),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            crossFadeState: expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 220),
            firstCurve: Curves.easeOutCubic,
            secondCurve: Curves.easeOutCubic,
            sizeCurve: Curves.easeOutCubic,
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: item.content,
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
          if (showDivider)
            Container(
              height: 1,
              color: borderColor,
            ),
        ],
      ),
    );
  }
}
