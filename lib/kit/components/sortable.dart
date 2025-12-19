import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A lightweight wrapper around ReorderableListView to provide
/// a clean, modern Sortable (drag-reorder) list.
class UkSortableList<T> extends StatelessWidget {
  const UkSortableList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onReorder,
    this.padding = EdgeInsets.zero,
    this.showHandle = true,
    this.handleAlignment = Alignment.centerRight,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final void Function(int oldIndex, int newIndex) onReorder;
  final EdgeInsets? padding;
  final bool showHandle;
  final Alignment handleAlignment;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ReorderableListView.builder(
      padding: padding,
      itemCount: items.length,
      buildDefaultDragHandles: false,
      onReorder: (oldIndex, newIndex) {
        try {
          if (kDebugMode) {
            debugPrint('UkSortableList reorder: $oldIndex → $newIndex');
          }
          onReorder(oldIndex, newIndex);
        } catch (e, st) {
          debugPrint('UkSortableList onReorder error: $e\n$st');
        }
      },
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          key: ValueKey('${item.hashCode}-$index'),
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3), width: 1),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: itemBuilder(context, item, index),
              ),
              if (showHandle)
                Positioned.fill(
                  child: Align(
                    alignment: handleAlignment,
                    child: ReorderableDragStartListener(
                      index: index,
                      child: Icon(Icons.drag_indicator, color: cs.onSurfaceVariant),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
