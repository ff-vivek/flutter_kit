import 'package:flutter/material.dart';

/// Dropbar: a full-width bar that drops below the app bar/nav to show rich content.
///
/// Inspired by UIkit Dropbar. Use [showUkDropbar] from any screen with an AppBar.
class UkDropbarController {
  UkDropbarController(this._entry, this._animationController);
  final OverlayEntry _entry;
  final AnimationController _animationController;
  bool _closed = false;

  bool get isOpen => !_closed;

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await _animationController.reverse();
    _entry.remove();
  }
}

Future<UkDropbarController> showUkDropbar(
  BuildContext context, {
  required Widget child,
  String? title,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  Duration duration = const Duration(milliseconds: 220),
}) async {
  final overlay = Overlay.of(context, rootOverlay: false);
  assert(overlay != null, 'No Overlay found in the context');

  final cs = Theme.of(context).colorScheme;
  final vsync = Navigator.of(context);

  late OverlayEntry entry;
  final animationController = AnimationController(vsync: vsync, duration: duration);
  final curved = CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic);

  entry = OverlayEntry(
    builder: (ctx) {
      final topInset = MediaQuery.of(ctx).padding.top;
      // Try to position under the typical AppBar height; if none, still respects safe area.
      final top = topInset + kToolbarHeight;

      return Stack(
        children: [
          // Tap outside to dismiss
          Positioned.fill(
            child: GestureDetector(
              onTap: () async {
                // Close handled by controller exposed to caller
                await animationController.reverse();
                entry.remove();
              },
              behavior: HitTestBehavior.opaque,
              child: ColoredBox(color: cs.scrim.withValues(alpha: 0.0)),
            ),
          ),
          Positioned(
            top: top,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, -0.04), end: Offset.zero).animate(curved),
                child: Material(
                  color: cs.surface,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.12)),
                        top: BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.12)),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: padding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title != null) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(title, style: Theme.of(ctx).textTheme.titleMedium),
                              ),
                            ],
                            child,
                          ],
                        ),
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

  overlay!.insert(entry);
  await animationController.forward();
  return UkDropbarController(entry, animationController);
}
