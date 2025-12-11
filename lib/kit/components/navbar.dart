import 'package:flutter/material.dart';

/// A modern, minimal top navigation bar inspired by UIkit's Navbar.
///
/// Supports a title/brand, a list of navigation items with an animated
/// underline indicator, and trailing action widgets. Use together with
/// [UkSubnav] for section-level navigation.
class UkNavbar extends StatelessWidget {
  const UkNavbar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.items = const [],
    this.selectedIndex = 0,
    this.onItemSelected,
    this.actions = const [],
    this.dense = false,
  });

  /// The brand/title as plain text. Ignored if [titleWidget] is provided.
  final String? title;

  /// Custom brand widget (e.g., logo + text).
  final Widget? titleWidget;

  /// Optional leading widget (e.g., app icon or menu button).
  final Widget? leading;

  /// Top-level navigation items.
  final List<UkNavbarItem> items;

  /// Index of the currently selected top-level item.
  final int selectedIndex;

  /// Callback when a top-level item is tapped.
  final ValueChanged<int>? onItemSelected;

  /// Trailing action widgets (e.g., buttons, avatar).
  final List<Widget> actions;

  /// Slightly reduce paddings and height.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final height = dense ? 56.0 : 64.0;
    final horizontalPadding = dense ? 12.0 : 16.0;

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.12), width: 1),
          ),
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],
            if (titleWidget != null)
              DefaultTextStyle(
                style: Theme.of(context).textTheme.titleLarge!,
                child: titleWidget!,
              )
            else if (title != null)
              Text(title!, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(width: 24),
            // Nav items
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final showLabels = constraints.maxWidth > 520;
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var i = 0; i < items.length; i++)
                            _NavButton(
                              item: items[i],
                              selected: i == selectedIndex,
                              showLabel: showLabels,
                              onTap: () => onItemSelected?.call(i),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Row(children: actions.map((w) => Padding(padding: const EdgeInsets.only(left: 8), child: w)).toList()),
          ],
        ),
      ),
    );
  }
}

class UkNavbarItem {
  const UkNavbarItem(this.label, {this.icon});
  final String label;
  final IconData? icon;
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.showLabel,
  });

  final UkNavbarItem item;
  final bool selected;
  final VoidCallback onTap;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelLarge!;
    final color = selected ? cs.primary : cs.onSurfaceVariant;
    final underlineColor = selected ? cs.primary : Colors.transparent;

    return InkWell(
      onTap: onTap,
      splashFactory: NoSplash.splashFactory,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: underlineColor, width: 2),
          ),
        ),
        child: Row(
          children: [
            if (item.icon != null) ...[
              Icon(item.icon, size: 18, color: color),
              if (showLabel) const SizedBox(width: 8),
            ],
            if (showLabel)
              Text(
                item.label,
                style: textStyle.copyWith(color: color),
              ),
          ],
        ),
      ),
    );
  }
}

/// Section-level navigation resembling UIkit's Subnav.
///
/// Two variants:
/// - underline: minimal links with animated underline for selection
/// - pills: rounded pills with filled style for selection
class UkSubnav extends StatelessWidget {
  const UkSubnav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.variant = UkSubnavVariant.underline,
    this.wrap = true,
  });

  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final UkSubnavVariant variant;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final children = [
      for (var i = 0; i < items.length; i++) _SubnavItem(index: i, label: items[i], selected: i == selectedIndex, onTap: () => onChanged(i), variant: variant),
    ];

    return wrap
        ? Wrap(spacing: 8, runSpacing: 8, children: children)
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}

enum UkSubnavVariant { underline, pills }

class _SubnavItem extends StatelessWidget {
  const _SubnavItem({
    required this.index,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.variant,
  });
  final int index;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final UkSubnavVariant variant;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelLarge!;

    switch (variant) {
      case UkSubnavVariant.underline:
        return InkWell(
          onTap: onTap,
          splashFactory: NoSplash.splashFactory,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: selected ? cs.primary : Colors.transparent, width: 2),
              ),
            ),
            child: Text(
              label,
              style: textStyle.copyWith(color: selected ? cs.primary : cs.onSurfaceVariant),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      case UkSubnavVariant.pills:
        return InkWell(
          onTap: onTap,
          splashFactory: NoSplash.splashFactory,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: selected ? cs.primary : cs.surface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: selected ? cs.primary : cs.onSurfaceVariant.withValues(alpha: 0.18)),
            ),
            child: Text(
              label,
              style: textStyle.copyWith(color: selected ? cs.onPrimary : cs.onSurface),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
    }
  }
}
