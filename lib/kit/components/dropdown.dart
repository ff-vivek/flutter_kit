import 'package:flutter/material.dart';

/// A modern dropdown menu anchored to a trigger widget.
/// Uses Material 3 MenuAnchor with styled MenuItemButton entries.
class UkDropdown extends StatefulWidget {
  const UkDropdown({
    super.key,
    required this.trigger,
    required this.items,
    this.alignmentOffset = const Offset(0, 8),
    this.closeOnSelect = true,
  });

  /// The widget that opens the menu when tapped.
  final Widget trigger;

  /// Menu items displayed when opened.
  final List<UkDropdownItem> items;

  /// Pixel offset from the trigger.
  final Offset alignmentOffset;

  /// Close the menu automatically after selecting an item.
  final bool closeOnSelect;

  @override
  State<UkDropdown> createState() => _UkDropdownState();
}

class _UkDropdownState extends State<UkDropdown> {
  final MenuController _controller = MenuController();

  void _toggle() {
    if (_controller.isOpen) {
      _controller.close();
    } else {
      _controller.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.labelLarge;

    return MenuAnchor(
      controller: _controller,
      alignmentOffset: widget.alignmentOffset,
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(cs.surface),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.12)),
          ),
        ),
        shadowColor: WidgetStatePropertyAll(cs.shadow.withValues(alpha: 0.12)),
      ),
      menuChildren: [
        for (final item in widget.items)
          MenuItemButton(
            onPressed: () {
              if (widget.closeOnSelect) {
                _controller.close();
              }
              item.onSelected?.call();
            },
            leadingIcon: item.icon == null
                ? null
                : Icon(
                    item.icon,
                    size: 20,
                    color: item.destructive ? cs.error : cs.primary,
                  ),
            style: MenuItemButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              foregroundColor: item.destructive ? cs.error : cs.onSurface,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    item.label,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.shortcut != null) ...[
                  const SizedBox(width: 16),
                  Text(
                    item.shortcut!,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ]
              ],
            ),
          ),
      ],
      builder: (context, controller, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.trigger,
              const SizedBox(width: 6),
              Icon(
                controller.isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: cs.primary,
                size: 18,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Data model for a dropdown menu item.
class UkDropdownItem {
  UkDropdownItem(
    this.label, {
    this.icon,
    this.onSelected,
    this.shortcut,
    this.destructive = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onSelected;
  final String? shortcut;
  final bool destructive;
}
