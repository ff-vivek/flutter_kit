import 'package:flutter/material.dart';

/// Breadcrumb navigation: displays a trail of links separated by chevrons.
class UkBreadcrumb extends StatelessWidget {
  const UkBreadcrumb({
    super.key,
    required this.items,
    this.onItemTap,
    this.separator,
  });

  /// The breadcrumb items in order. Last item is treated as current.
  final List<UkBreadcrumbItem> items;

  /// Optional tap handler. If null, uses item.onTap; last item is not tappable.
  final void Function(int index, UkBreadcrumbItem item)? onItemTap;

  /// Optional custom separator widget. Defaults to chevron_right icon.
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final sep = separator ?? Icon(Icons.chevron_right, size: 16, color: cs.onSurfaceVariant);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          _UkBreadcrumbChip(
            label: items[i].label,
            icon: items[i].icon,
            clickable: i != items.length - 1,
            onTap: i == items.length - 1
                ? null
                : () {
                    if (onItemTap != null) {
                      onItemTap!(i, items[i]);
                    } else {
                      items[i].onTap?.call();
                    }
                  },
          ),
          if (i != items.length - 1) sep,
        ],
      ],
    );
  }
}

class _UkBreadcrumbChip extends StatelessWidget {
  const _UkBreadcrumbChip({
    required this.label,
    this.icon,
    required this.clickable,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool clickable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: clickable ? cs.primary : cs.onSurfaceVariant,
          fontWeight: clickable ? FontWeight.w500 : FontWeight.w400,
        );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: textStyle?.color ?? cs.primary),
          const SizedBox(width: 6),
        ],
        Text(label, style: textStyle),
      ],
    );

    if (!clickable) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: content,
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: content,
      ),
    );
  }
}

class UkBreadcrumbItem {
  const UkBreadcrumbItem(this.label, {this.icon, this.onTap});
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
}
