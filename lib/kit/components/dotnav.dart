import 'package:flutter/material.dart';

/// Dot-based pagination control (UIkit Dotnav).
class UkDotnav extends StatelessWidget {
  const UkDotnav({
    super.key,
    required this.length,
    required this.currentIndex,
    required this.onChanged,
    this.size = UkDotnavSize.medium,
    this.spacing = 10,
  });

  final int length;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final UkDotnavSize size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dims = switch (size) {
      UkDotnavSize.small => (diameter: 6.0, active: 8.0),
      UkDotnavSize.medium => (diameter: 8.0, active: 10.0),
      UkDotnavSize.large => (diameter: 10.0, active: 12.0),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < length; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: _Dot(
              selected: i == currentIndex,
              onTap: () => onChanged(i),
              color: cs.primary,
              inactiveColor: cs.onSurfaceVariant.withValues(alpha: 0.4),
              diameter: dims.diameter,
              activeDiameter: dims.active,
            ),
          ),
      ],
    );
  }
}

enum UkDotnavSize { small, medium, large }

class _Dot extends StatefulWidget {
  const _Dot({
    required this.selected,
    required this.onTap,
    required this.color,
    required this.inactiveColor,
    required this.diameter,
    required this.activeDiameter,
  });

  final bool selected;
  final VoidCallback onTap;
  final Color color;
  final Color inactiveColor;
  final double diameter;
  final double activeDiameter;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.selected
        ? widget.activeDiameter
        : _hover
            ? (widget.diameter + widget.activeDiameter) / 2
            : widget.diameter;
    final color = widget.selected ? widget.color : widget.inactiveColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        customBorder: const CircleBorder(),
        splashFactory: NoSplash.splashFactory,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          width: d,
          height: d,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
