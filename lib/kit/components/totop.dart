import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Floating “Back to top” control that shows after you scroll past [threshold].
///
/// Place this in Scaffold.floatingActionButton (recommended) or anywhere in a
/// Stack-aligned corner. If [controller] is null, it uses the nearest
/// PrimaryScrollController.
class UkToTopFab extends StatefulWidget {
  const UkToTopFab({
    super.key,
    this.controller,
    this.threshold = 280,
    this.tooltip = 'Back to top',
  });

  final ScrollController? controller;
  final double threshold;
  final String tooltip;

  @override
  State<UkToTopFab> createState() => _UkToTopFabState();
}

class _UkToTopFabState extends State<UkToTopFab> {
  ScrollController? _controller;
  bool _visible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachController();
  }

  @override
  void didUpdateWidget(covariant UkToTopFab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _detachController();
      _attachController();
    }
  }

  void _attachController() {
    _controller = widget.controller ?? PrimaryScrollController.of(context);
    _controller?.addListener(_onScroll);
    _onScroll();
  }

  void _detachController() {
    _controller?.removeListener(_onScroll);
  }

  void _onScroll() {
    final offset = _controller?.positions.isNotEmpty == true
        ? _controller!.positions.first.pixels
        : (_controller?.hasClients == true ? _controller!.offset : 0.0);
    final shouldShow = offset > widget.threshold;
    if (shouldShow != _visible && mounted) {
      setState(() => _visible = shouldShow);
    }
  }

  @override
  void dispose() {
    _detachController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return IgnorePointer(
      ignoring: !_visible,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOutCubic,
        child: AnimatedScale(
          scale: _visible ? 1 : 0.9,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          child: Material(
            color: cs.primary,
            shape: const CircleBorder(),
            elevation: 0,
            child: InkWell(
              customBorder: const CircleBorder(),
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                final c = _controller ?? PrimaryScrollController.of(context);
                if (c != null && c.hasClients) {
                  final distance = c.offset;
                  // Duration based on distance, capped.
                  final ms = (math.min(800, (distance / 3).clamp(250.0, 800.0))).toInt();
                  c.animateTo(0,
                      duration: Duration(milliseconds: ms),
                      curve: Curves.easeOutCubic);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Icon(Icons.arrow_upward_rounded, color: cs.onPrimary, size: 22),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
