import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// UkScrollspy — Animate child when it enters the viewport (fade/slide).
///
/// Works when placed inside a Scrollable (e.g., ListView, SingleChildScrollView).
/// It observes the nearest Scrollable via Scrollable.of(context) and triggers
/// the animation once when the widget becomes sufficiently visible.
class UkScrollspy extends StatefulWidget {
  const UkScrollspy({
    super.key,
    required this.child,
    this.curve = Curves.easeOutCubic,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 24),
    this.fade = true,
    this.threshold = 0.15,
  });

  /// The widget to animate into view.
  final Widget child;
  final Curve curve;
  final Duration duration;
  final Duration delay;
  final Offset offset; // starting translate offset
  final bool fade; // whether to animate opacity
  /// Fraction (0..1) of height that must be visible to trigger
  final double threshold;

  @override
  State<UkScrollspy> createState() => _UkScrollspyState();
}

class _UkScrollspyState extends State<UkScrollspy> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;
  ScrollPosition? _position;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _t = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Attach to the nearest scrollable
    final scrollable = Scrollable.of(context);
    final pos = scrollable?.position;
    if (_position != pos) {
      _position?.removeListener(_onScroll);
      _position = pos;
      _position?.addListener(_onScroll);
      // initial check after layout
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_triggered) {
      _checkVisibility();
    }
  }

  void _checkVisibility() {
    if (!mounted || _triggered) return;
    try {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return;
      final size = box.size;
      final topLeft = box.localToGlobal(Offset.zero);
      final bottomRight = box.localToGlobal(Offset(size.width, size.height));

      final rectTop = topLeft.dy;
      final rectBottom = bottomRight.dy;

      // Viewport bounds (approximate to full screen). This works for typical layouts.
      final media = MediaQuery.of(context);
      final viewTop = media.padding.top; // below status bar
      final viewBottom = media.size.height - media.padding.bottom;

      final visibleHeight = math.max(0.0, math.min(rectBottom, viewBottom) - math.max(rectTop, viewTop));
      final fractionVisible = visibleHeight / size.height;
      if (fractionVisible >= widget.threshold) {
        _triggered = true;
        if (widget.delay == Duration.zero) {
          _controller.forward();
        } else {
          Future.delayed(widget.delay, () {
            if (mounted) _controller.forward();
          });
        }
      }
    } catch (e, st) {
      debugPrint('UkScrollspy visibility check error: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _t,
      builder: (context, child) {
        final dx = (1 - _t.value) * widget.offset.dx;
        final dy = (1 - _t.value) * widget.offset.dy;
        final opacity = widget.fade ? _t.value : 1.0;
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(dx, dy),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
