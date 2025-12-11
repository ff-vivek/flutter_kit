import 'package:flutter/material.dart';

class UkIconnavItem {
  const UkIconnavItem(this.icon, {this.tooltip});
  final IconData icon;
  final String? tooltip;
}

enum UkIconnavOrientation { vertical, horizontal }

class UkIconnav extends StatelessWidget {
  const UkIconnav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.orientation = UkIconnavOrientation.vertical,
  });

  final List<UkIconnavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final UkIconnavOrientation orientation;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      final active = i == selectedIndex;
      final item = items[i];
      final btn = InkWell(
        onTap: () => onChanged(i),
        borderRadius: BorderRadius.circular(10),
        splashFactory: NoSplash.splashFactory,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: active ? cs.primary.withValues(alpha: 0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
          ),
          alignment: Alignment.center,
          child: Icon(item.icon, color: active ? cs.primary : cs.onSurfaceVariant),
        ),
      );
      children.add(item.tooltip != null ? Tooltip(message: item.tooltip!, child: btn) : btn);
    }

    return orientation == UkIconnavOrientation.vertical
        ? Column(mainAxisSize: MainAxisSize.min, children: _spaced(children))
        : Row(mainAxisSize: MainAxisSize.min, children: _spaced(children));
  }

  List<Widget> _spaced(List<Widget> list) {
    return [
      for (var i = 0; i < list.length; i++) ...[
        if (i > 0) const SizedBox(width: 8, height: 8),
        list[i],
      ]
    ];
  }
}
