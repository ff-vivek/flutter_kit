import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Slidenav: Large prev/next overlay controls commonly used over carousels or hero media.
///
/// Wrap content with [UkSlidenav] and wire [onPrevious]/[onNext]. It adds keyboard
/// left/right shortcuts and hover-friendly, high-contrast buttons.
class UkSlidenav extends StatelessWidget {
  const UkSlidenav({
    super.key,
    required this.child,
    this.onPrevious,
    this.onNext,
    this.showHints = true,
  });

  final Widget child;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool showHints;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return FocusableActionDetector(
      autofocus: false,
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const _PrevIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const _NextIntent(),
      },
      actions: {
        _PrevIntent: CallbackAction<_PrevIntent>(onInvoke: (_) {
          onPrevious?.call();
          return null;
        }),
        _NextIntent: CallbackAction<_NextIntent>(onInvoke: (_) {
          onNext?.call();
          return null;
        }),
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          child,
          if (onPrevious != null)
            Align(
              alignment: Alignment.centerLeft,
              child: _NavButton(
                icon: Icons.chevron_left,
                color: cs.onSurface,
                background: cs.surface.withValues(alpha: 0.72),
                onTap: onPrevious!,
                tooltip: 'Previous',
              ),
            ),
          if (onNext != null)
            Align(
              alignment: Alignment.centerRight,
              child: _NavButton(
                icon: Icons.chevron_right,
                color: cs.onSurface,
                background: cs.surface.withValues(alpha: 0.72),
                onTap: onNext!,
                tooltip: 'Next',
              ),
            ),
          if (showHints && (onPrevious != null || onNext != null))
            Positioned(
              left: 0,
              right: 0,
              bottom: 8,
              child: IgnorePointer(
                ignoring: true,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: 0.64),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cs.onSurfaceVariant.withValues(alpha: 0.18)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Text('Use ← → to navigate', style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PrevIntent extends Intent {
  const _PrevIntent();
}

class _NextIntent extends Intent {
  const _NextIntent();
}

class _NavButton extends StatefulWidget {
  const _NavButton({
    required this.icon,
    required this.onTap,
    required this.color,
    required this.background,
    required this.tooltip,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final Color background;
  final String tooltip;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = _hover ? cs.primaryContainer : widget.background;
    final fg = _hover ? cs.onPrimaryContainer : widget.color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: Tooltip(
          message: widget.tooltip,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(28),
            splashFactory: NoSplash.splashFactory,
            child: Ink(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: cs.onSurfaceVariant.withValues(alpha: 0.2)),
              ),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(widget.icon, color: fg, size: 28),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
