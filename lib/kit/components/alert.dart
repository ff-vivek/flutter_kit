import 'package:flutter/material.dart';

/// Alert types inspired by UIkit: info, success, warning, danger
enum UkAlertType { info, success, warning, danger }

/// Dismissible alert banner with variant colors and optional leading icon.
class UkAlert extends StatefulWidget {
  const UkAlert({
    super.key,
    required this.message,
    this.type = UkAlertType.info,
    this.icon,
    this.dismissible = true,
    this.onDismissed,
  });

  final String message;
  final UkAlertType type;
  final IconData? icon;
  final bool dismissible;
  final VoidCallback? onDismissed;

  @override
  State<UkAlert> createState() => _UkAlertState();
}

class _UkAlertState extends State<UkAlert> with TickerProviderStateMixin {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Map alert type to container/onContainer pairs
    final (bg, fg) = switch (widget.type) {
      UkAlertType.info => (cs.primaryContainer, cs.onPrimaryContainer),
      UkAlertType.success => (cs.tertiaryContainer, cs.onTertiaryContainer),
      UkAlertType.warning => (cs.secondaryContainer, cs.onSecondaryContainer),
      UkAlertType.danger => (cs.errorContainer, cs.onErrorContainer),
    };

    final iconData = widget.icon ?? switch (widget.type) {
      UkAlertType.info => Icons.info_outline,
      UkAlertType.success => Icons.check_circle_outline,
      UkAlertType.warning => Icons.warning_amber_outlined,
      UkAlertType.danger => Icons.error_outline,
    };

    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: _visible
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: fg.withValues(alpha: 0.18)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(iconData, color: fg, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: fg),
                    ),
                  ),
                  if (widget.dismissible)
                    GestureDetector(
                      onTap: () {
                        setState(() => _visible = false);
                        widget.onDismissed?.call();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.close, size: 18, color: fg),
                      ),
                    ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
