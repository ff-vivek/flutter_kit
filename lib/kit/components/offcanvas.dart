import 'package:flutter/material.dart';

/// Side panel overlay inspired by UIkit Offcanvas.
///
/// Use [showUkOffcanvas] to display a slide-in panel from left or right.
enum UkOffcanvasSide { left, right }

Future<void> showUkOffcanvas(
  BuildContext context, {
  required Widget child,
  UkOffcanvasSide side = UkOffcanvasSide.left,
  double? width,
  String? title,
}) async {
  final cs = Theme.of(context).colorScheme;
  final panelWidth = width ?? (MediaQuery.of(context).size.width * 0.86).clamp(280.0, 420.0);

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: cs.scrim.withValues(alpha: 0.4),
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (_, __, ___) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, _) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      final offsetTween = Tween<Offset>(
        begin: side == UkOffcanvasSide.left ? const Offset(-1, 0) : const Offset(1, 0),
        end: Offset.zero,
      );

      return Stack(
        children: [
          // Barrier handled by showGeneralDialog
          Align(
            alignment: side == UkOffcanvasSide.left ? Alignment.centerLeft : Alignment.centerRight,
            child: SlideTransition(
              position: offsetTween.animate(curved),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: panelWidth),
                child: SafeArea(
                  child: Material(
                    color: cs.surface,
                    elevation: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          right: side == UkOffcanvasSide.left
                              ? BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.12))
                              : BorderSide.none,
                          left: side == UkOffcanvasSide.right
                              ? BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.12))
                              : BorderSide.none,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title ?? 'Menu',
                                    style: Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.of(context).maybePop(),
                                  icon: Icon(Icons.close, color: cs.onSurface),
                                  tooltip: 'Close',
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          // Body
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: child,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
