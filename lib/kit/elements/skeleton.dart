import 'package:flutter/material.dart';

/// UkSkeleton
/// Minimal shimmer-style placeholder for loading states.
enum UkSkeletonShape { rect, circle }

class UkSkeleton extends StatefulWidget {
  const UkSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
    this.shape = UkSkeletonShape.rect,
    this.duration = const Duration(milliseconds: 1200),
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final UkSkeletonShape shape;
  final Duration duration;

  @override
  State<UkSkeleton> createState() => _UkSkeletonState();
}

class _UkSkeletonState extends State<UkSkeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: widget.duration)..repeat();
  late final Animation<double> _t = Tween(begin: -1.0, end: 2.0).animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = cs.surfaceVariant.withValues(alpha: 0.6);
    final highlight = cs.onSurface.withValues(alpha: 0.06);

    final radius = widget.shape == UkSkeletonShape.circle
        ? BorderRadius.circular(999)
        : (widget.borderRadius ?? BorderRadius.circular(8));

    return AnimatedBuilder(
      animation: _t,
      builder: (context, _) {
        final dx = _t.value;
        return ClipRRect(
          borderRadius: radius,
          child: CustomPaint(
            painter: _SkeletonPainter(base: base, highlight: highlight, dx: dx),
            child: SizedBox(width: widget.width, height: widget.height),
          ),
        );
      },
    );
  }
}

class _SkeletonPainter extends CustomPainter {
  _SkeletonPainter({required this.base, required this.highlight, required this.dx});
  final Color base;
  final Color highlight;
  final double dx; // -1..2

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = _shader(size);
    canvas.drawRect(Offset.zero & size, paint);
  }

  Shader _shader(Size size) {
    final w = size.width;
    final stops = [dx - 0.2, dx, dx + 0.2];
    return LinearGradient(
      colors: [base, highlight, base],
      stops: stops.map((s) => s.clamp(0.0, 1.0)).toList(),
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(Offset.zero & Size(w, size.height));
  }

  @override
  bool shouldRepaint(covariant _SkeletonPainter oldDelegate) => oldDelegate.dx != dx || oldDelegate.base != base || oldDelegate.highlight != highlight;
}
