import 'package:flutter/material.dart';
import '../../theme.dart';

/// List variants matching UIkit-inspired styles
enum UkListVariant { plain, divided, striped, condensed }

/// Data model for UkList items
class UkListItemData {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const UkListItemData(
    this.title, {
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });
}

/// A modern, minimal list element with optional divided/striped/condensed styles
class UkList extends StatelessWidget {
  final List<UkListItemData> items;
  final UkListVariant variant;
  final EdgeInsets? padding;
  final double radius;

  const UkList({
    super.key,
    required this.items,
    this.variant = UkListVariant.plain,
    this.padding,
    this.radius = AppRadius.md,
  });

  bool get _isDivided => variant == UkListVariant.divided;
  bool get _isStriped => variant == UkListVariant.striped;
  bool get _isCondensed => variant == UkListVariant.condensed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final EdgeInsets resolvedPadding = padding ?? const EdgeInsets.symmetric(vertical: 4);
    final double vPad = _isCondensed ? 8 : 12;
    final itemPadding = EdgeInsets.symmetric(horizontal: 12, vertical: vPad);

    final List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final bool showStripe = _isStriped && i.isEven;
      final backgroundColor = showStripe ? cs.surfaceContainerHighest.withValues(alpha: 0.5) : Colors.transparent;

      children.add(
        _UkListTile(
          data: item,
          backgroundColor: backgroundColor,
          padding: itemPadding,
          radius: radius,
        ),
      );

      if (_isDivided && i != items.length - 1) {
        children.add(Divider(
          height: 1,
          thickness: 1,
          color: cs.outline.withValues(alpha: 0.15),
        ));
      }
    }

    return Padding(
      padding: resolvedPadding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

/// Public list tile widget for building custom UkList items
class UkListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final double radius;

  const UkListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.radius = AppRadius.md,
  });

  @override
  Widget build(BuildContext context) {
    return _UkListTile(
      data: UkListItemData(title, subtitle: subtitle, leading: leading, trailing: trailing, onTap: onTap),
      padding: padding,
      radius: radius,
    );
  }
}

class _UkListTile extends StatefulWidget {
  final UkListItemData data;
  final Color backgroundColor;
  final EdgeInsets padding;
  final double radius;

  const _UkListTile({
    required this.data,
    this.backgroundColor = Colors.transparent,
    required this.padding,
    required this.radius,
  });

  @override
  State<_UkListTile> createState() => _UkListTileState();
}

class _UkListTileState extends State<_UkListTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = _hovered
        ? cs.primary.withValues(alpha: 0.06)
        : widget.backgroundColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.data.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          padding: widget.padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.data.leading != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: IconTheme(
                    data: IconThemeData(color: cs.onSurfaceVariant),
                    child: widget.data.leading!,
                  ),
                )
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
                      style: Theme.of(context).textTheme.bodyLarge!.semiBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.data.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.data.subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium!.withColor(cs.onSurfaceVariant),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.data.trailing != null) ...[
                const SizedBox(width: 12),
                widget.data.trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
