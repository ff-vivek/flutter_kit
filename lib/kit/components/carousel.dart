import 'dart:async';
import 'package:flutter/material.dart';

/// Simple carousel/slideshow with PageView and dots indicator.
class UkCarousel extends StatefulWidget {
  const UkCarousel({
    super.key,
    required this.items,
    this.height = 200,
    this.autoPlay = true,
    this.interval = const Duration(seconds: 4),
    this.viewportFraction = 1.0,
    this.showDots = true,
  });

  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final Duration interval;
  final double viewportFraction;
  final bool showDots;

  @override
  State<UkCarousel> createState() => _UkCarouselState();
}

class _UkCarouselState extends State<UkCarousel> {
  late final PageController _controller;
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.viewportFraction);
    if (widget.autoPlay && widget.items.length > 1) {
      _timer = Timer.periodic(widget.interval, (_) {
        if (!mounted) return;
        final next = (_index + 1) % widget.items.length;
        _controller.animateToPage(next, duration: const Duration(milliseconds: 260), curve: Curves.easeOutCubic);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) => widget.items[i],
          ),
        ),
        if (widget.showDots && widget.items.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.items.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _index ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _index ? cs.primary : cs.onSurfaceVariant.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
