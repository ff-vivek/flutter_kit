import 'package:flutter/material.dart';

enum UkToastType { info, success, warning, danger }

/// Lightweight toast/notification using ScaffoldMessenger SnackBar with modern styling.
class UkToast {
  static void show(
    BuildContext context, {
    required String message,
    UkToastType type = UkToastType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final cs = Theme.of(context).colorScheme;
    final (bg, fg) = switch (type) {
      UkToastType.info => (cs.primaryContainer, cs.onPrimaryContainer),
      UkToastType.success => (cs.secondaryContainer, cs.onSecondaryContainer),
      UkToastType.warning => (cs.tertiaryContainer, cs.onTertiaryContainer),
      UkToastType.danger => (cs.errorContainer, cs.onErrorContainer),
    };

    final snackBar = SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: fg),
      ),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      backgroundColor: bg,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cs.onSurfaceVariant.withValues(alpha: 0.12)),
      ),
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(
              label: actionLabel,
              onPressed: onAction,
              textColor: fg,
              disabledTextColor: fg,
            )
          : null,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
