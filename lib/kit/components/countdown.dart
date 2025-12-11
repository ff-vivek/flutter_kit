import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

/// A simple, theme-aware countdown to a target [DateTime].
///
/// Displays days, hours, minutes, seconds in compact tiles. Calls
/// [onComplete] when it reaches zero.
class UkCountdown extends StatefulWidget {
  const UkCountdown({
    super.key,
    required this.target,
    this.onComplete,
    this.showDays = true,
    this.spacing = 8,
    this.pad = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    this.radius = 10,
  });

  final DateTime target;
  final VoidCallback? onComplete;
  final bool showDays;
  final double spacing;
  final EdgeInsets pad;
  final double radius;

  @override
  State<UkCountdown> createState() => _UkCountdownState();
}

class _UkCountdownState extends State<UkCountdown> {
  late Timer _timer;
  late Duration _remaining;
  bool _completedNotified = false;

  @override
  void initState() {
    super.initState();
    _remaining = _calcRemaining();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final r = _calcRemaining();
      if (mounted) {
        setState(() => _remaining = r);
      }
      if (r.inSeconds <= 0 && !_completedNotified) {
        _completedNotified = true;
        widget.onComplete?.call();
      }
    });
  }

  Duration _calcRemaining() {
    final now = DateTime.now();
    final diff = widget.target.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalSeconds = _remaining.inSeconds;
    int days = widget.showDays ? _remaining.inDays : 0;
    int hours = widget.showDays
        ? _remaining.inHours % 24
        : _remaining.inHours; // if not showing days, roll up
    int minutes = _remaining.inMinutes % 60;
    int seconds = totalSeconds % 60;

    final tiles = <_TimeTileData>[];
    if (widget.showDays) tiles.add(_TimeTileData(value: days, label: 'Days'));
    tiles
      ..add(_TimeTileData(value: hours, label: 'Hours'))
      ..add(_TimeTileData(value: minutes, label: 'Minutes'))
      ..add(_TimeTileData(value: seconds, label: 'Seconds'));

    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.spacing,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: tiles
          .map((t) => _TimeTile(
                value: t.value,
                label: t.label,
                pad: widget.pad,
                radius: widget.radius,
              ))
          .toList(),
    );
  }
}

class _TimeTileData {
  _TimeTileData({required this.value, required this.label});
  final int value;
  final String label;
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({
    required this.value,
    required this.label,
    required this.pad,
    required this.radius,
  });

  final int value;
  final String label;
  final EdgeInsets pad;
  final double radius;

  String _two(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: pad,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _two(value),
            style: textTheme.titleLarge?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}
