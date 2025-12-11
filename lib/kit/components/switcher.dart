import 'package:flutter/material.dart';

/// Content switcher with simple transitions (fade or slide).
///
/// Control it by passing the current [index]. Use together with Tabs/Subnav.
class UkSwitcher extends StatelessWidget {
  const UkSwitcher({
    super.key,
    required this.index,
    required this.children,
    this.transition = UkSwitcherTransition.fade,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
  }) : assert(children.length > 0);

  final int index;
  final List<Widget> children;
  final UkSwitcherTransition transition;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: ValueKey(index), child: children[index.clamp(0, children.length - 1)]);
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      transitionBuilder: (c, anim) {
        return switch (transition) {
          UkSwitcherTransition.fade => FadeTransition(opacity: anim, child: c),
          UkSwitcherTransition.slideX => SlideTransition(
              position: Tween<Offset>(begin: const Offset(0.06, 0), end: Offset.zero).animate(anim),
              child: FadeTransition(opacity: anim, child: c),
            ),
          UkSwitcherTransition.slideY => SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(anim),
              child: FadeTransition(opacity: anim, child: c),
            ),
        };
      },
      child: child,
    );
  }
}

enum UkSwitcherTransition { fade, slideX, slideY }
