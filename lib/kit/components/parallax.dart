import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// UkParallax
/// A lightweight parallax wrapper that translates its child based on scroll.
///
/// Place inside a scrollable (e.g., ListView). The widget measures its
/// position relative to the viewport center and offsets the child by
/// `delta * speed` along the selected axis.
class UkParallax extends StatefulWidget {
  const UkParallax({
    super.key,
    required this.child,
    this.speed = 0.25,
    this.axis = Axis.vertical,
  });

  /// The parallaxed content, typically a large image.
  final Widget child;

  /// Multiplier that controls the translation intensity. Typical: 0.15–0.4
  final double speed;

  /// Axis along which to apply the effect.
  final Axis axis;

  @override
  State<UkParallax> createState() => _UkParallaxState();
}

class _UkParallaxState extends State<UkParallax> {
  ScrollPosition? _position;
  double _offset = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attach();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateOffset());
  }

  @override
  void dispose() {
    _detach();
    super.dispose();
  }

  void _attach() {
    final pos = Scrollable.of(context)?.position;
    if (_position == pos) return;
    _detach();
    _position = pos;
    _position?.addListener(_updateOffset);
  }

  void _detach() {
    _position?.removeListener(_updateOffset);
    _position = null;
  }

  void _updateOffset() {
    if (!mounted) return;
    try {
      final render = context.findRenderObject() as RenderBox?;
      if (render == null || !render.attached) return;
      final size = render.size;
      final topLeft = render.localToGlobal(Offset.zero);
      final viewport = MediaQuery.of(context).size;
      final itemCenterDy = topLeft.dy + size.height / 2;
      final viewportCenterDy = viewport.height / 2;
      final deltaDy = itemCenterDy - viewportCenterDy; // positive if below center

      final itemCenterDx = topLeft.dx + size.width / 2;
      final viewportCenterDx = viewport.width / 2;
      final deltaDx = itemCenterDx - viewportCenterDx;

      final delta = widget.axis == Axis.vertical ? deltaDy : deltaDx;
      final next = -delta * widget.speed;
      if (next == _offset) return;
      setState(() => _offset = next);
    } catch (e, st) {
      debugPrint('UkParallax _updateOffset error: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    final translation = widget.axis == Axis.vertical ? Offset(0, _offset) : Offset(_offset, 0);
    return ClipRect(
      child: Transform.translate(
        offset: translation,
        child: widget.child,
      ),
    );
  }
}
