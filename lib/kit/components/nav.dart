import 'package:flutter/material.dart';

/// Vertical navigation list inspired by UIkit's Nav.
///
/// Features:
/// - Active item highlight with subtle background and left indicator
/// - Optional leading icons and trailing badges/counts
/// - Compact, minimalist look; no ripple splash per design guidelines
class UkNav extends StatelessWidget {
  const UkNav({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onChanged,
    this.dense = false,
  });

  final List<UkNavItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < items.length; i++)
          _NavTile(
            item: items[i],
            selected: i == selectedIndex,
            onTap: () => onChanged?.call(i),
            dense: dense,
            primaryColor: cs.primary,
            surface: cs.surface,
            onSurfaceVariant: cs.onSurfaceVariant,
          ),
      ],
    );
  }
}

class UkNavItem {
  const UkNavItem(this.label, {this.icon, this.badge});
  final String label;
  final IconData? icon;
  final String? badge; // optional trailing badge/counter
}

class _NavTile extends StatefulWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.dense,
    required this.primaryColor,
    required this.surface,
    required this.onSurfaceVariant,
  });

  final UkNavItem item;
  final bool selected;
  final VoidCallback onTap;
  final bool dense;
  final Color primaryColor;
  final Color surface;
  final Color onSurfaceVariant;

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final cs = Theme.of(context).colorScheme;
    final bg = selected
        ? cs.primary.withValues(alpha: 0.08)
        : _hover
            ? cs.primary.withValues(alpha: 0.05)
            : Colors.transparent;

    final textColor = selected ? cs.primary : cs.onSurface;
    final labelStyle = Theme.of(context).textTheme.labelLarge!;
    final height = widget.dense ? 40.0 : 44.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        splashFactory: NoSplash.splashFactory,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                width: 3,
                height: 16,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: selected ? cs.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (widget.item.icon != null) ...[
                Icon(widget.item.icon, size: 18, color: textColor),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  widget.item.label,
                  style: labelStyle.copyWith(color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.item.badge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    widget.item.badge!,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
