import 'package:flutter/material.dart';

/// Image/content overlay that appears on hover (desktop/web) or tap (mobile).
class UkOverlay extends StatefulWidget {
  const UkOverlay({
    super.key,
    required this.child,
    required this.overlay,
    this.alignment = Alignment.center,
    this.radius = 12,
    this.backgroundColor,
    this.enableTapToggle = true,
  });

  final Widget child;
  final Widget overlay;
  final Alignment alignment;
  final double radius;
  final Color? backgroundColor;
  final bool enableTapToggle;

  @override
  State<UkOverlay> createState() => _UkOverlayState();
}

class _UkOverlayState extends State<UkOverlay> {
  bool _hovered = false;
  bool _tapped = false;

  bool get _visible => _hovered || _tapped;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = widget.backgroundColor ?? cs.scrim.withValues(alpha: 0.5);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.enableTapToggle ? () => setState(() => _tapped = !_tapped) : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Stack(
            alignment: widget.alignment,
            children: [
              Positioned.fill(child: widget.child),
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: !_visible,
                  child: AnimatedOpacity(
                    opacity: _visible ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      color: bg,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        offset: _visible ? Offset.zero : const Offset(0, 0.06),
                        child: widget.overlay,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
