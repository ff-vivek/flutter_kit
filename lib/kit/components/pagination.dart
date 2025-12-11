import 'package:flutter/material.dart';

/// Simple, accessible pagination control with prev/next and page numbers.
class UkPagination extends StatelessWidget {
  const UkPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.maxPagesToShow = 5,
    this.showEdges = true,
  }) : assert(currentPage >= 1 && totalPages >= 1);

  final int currentPage;
  final int totalPages;
  final int maxPagesToShow;
  final bool showEdges;
  final ValueChanged<int> onPageChanged;

  List<int?> _visiblePages() {
    // Returns a list of page numbers to display; null indicates ellipsis
    final pages = <int?>[];
    if (totalPages <= maxPagesToShow) {
      for (var i = 1; i <= totalPages; i++) pages.add(i);
      return pages;
    }

    final half = (maxPagesToShow / 2).floor();
    var start = currentPage - half;
    var end = currentPage + half;
    if (maxPagesToShow.isEven) end -= 1; // keep count consistent

    if (start < 1) {
      end += 1 - start;
      start = 1;
    }
    if (end > totalPages) {
      start -= end - totalPages;
      end = totalPages;
    }
    start = start.clamp(1, totalPages);
    end = end.clamp(1, totalPages);

    if (showEdges && start > 1) {
      pages..add(1)..add(null);
    }

    for (var i = start; i <= end; i++) {
      pages.add(i);
    }

    if (showEdges && end < totalPages) {
      pages..add(null)..add(totalPages);
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget pageButton(int page) {
      final bool isCurrent = page == currentPage;
      if (isCurrent) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: FilledButton(
            onPressed: null,
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              splashFactory: NoSplash.splashFactory,
            ),
            child: Text('$page', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onPrimary)),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: () => onPageChanged(page),
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            side: WidgetStatePropertyAll(BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.2))),
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text('$page', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.primary)),
        ),
      );
    }

    Widget navButton({required IconData icon, required bool enabled, required VoidCallback onTap}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: enabled ? onTap : null,
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            side: WidgetStatePropertyAll(BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.2))),
            splashFactory: NoSplash.splashFactory,
          ),
          child: Icon(icon, size: 18, color: enabled ? cs.primary : cs.onSurfaceVariant),
        ),
      );
    }

    final pages = _visiblePages();

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        navButton(
          icon: Icons.chevron_left,
          enabled: currentPage > 1,
          onTap: () => onPageChanged(currentPage - 1),
        ),
        for (final p in pages)
          if (p == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text('…', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onSurfaceVariant)),
            )
          else
            pageButton(p),
        navButton(
          icon: Icons.chevron_right,
          enabled: currentPage < totalPages,
          onTap: () => onPageChanged(currentPage + 1),
        ),
      ],
    );
  }
}
