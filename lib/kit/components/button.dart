import 'package:flutter/material.dart';

enum UkButtonVariant { primary, secondary, tonal, outline, text }
enum UkButtonSize { small, medium, large }

class UkButton extends StatelessWidget {
  const UkButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = UkButtonVariant.primary,
    this.size = UkButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final UkButtonVariant variant;
  final UkButtonSize size;

  EdgeInsetsGeometry get _padding => switch (size) {
        UkButtonSize.small => const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        UkButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        UkButtonSize.large => const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      };

  ButtonStyle _baseStyle(BuildContext context) {
    final shape = WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
    final padding = WidgetStatePropertyAll(_padding);
    return ButtonStyle(
      shape: shape,
      padding: padding,
      splashFactory: NoSplash.splashFactory,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              icon,
              size: switch (size) {
                UkButtonSize.small => 16,
                UkButtonSize.medium => 18,
                UkButtonSize.large => 20,
              },
              color: switch (variant) {
                UkButtonVariant.primary => cs.onPrimary,
                UkButtonVariant.secondary => cs.onSecondary,
                UkButtonVariant.tonal => cs.onPrimaryContainer,
                UkButtonVariant.outline => cs.primary,
                UkButtonVariant.text => cs.primary,
              },
            ),
          ),
        Text(
          label,
          style: switch (variant) {
            UkButtonVariant.primary => Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onPrimary),
            UkButtonVariant.secondary => Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onSecondary),
            UkButtonVariant.tonal => Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.onPrimaryContainer),
            UkButtonVariant.outline => Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.primary),
            UkButtonVariant.text => Theme.of(context).textTheme.labelLarge?.copyWith(color: cs.primary),
          },
        ),
      ],
    );

    switch (variant) {
      case UkButtonVariant.primary:
        return FilledButton(
          onPressed: onPressed,
          style: _baseStyle(context),
          child: child,
        );
      case UkButtonVariant.secondary:
        return FilledButton(
          onPressed: onPressed,
          style: _baseStyle(context).copyWith(
            backgroundColor: WidgetStatePropertyAll(cs.secondary),
            foregroundColor: WidgetStatePropertyAll(cs.onSecondary),
          ),
          child: child,
        );
      case UkButtonVariant.tonal:
        return FilledButton.tonal(
          onPressed: onPressed,
          style: _baseStyle(context),
          child: child,
        );
      case UkButtonVariant.outline:
        return OutlinedButton(
          onPressed: onPressed,
          style: _baseStyle(context).copyWith(
            side: WidgetStatePropertyAll(BorderSide(color: cs.primary)),
          ),
          child: child,
        );
      case UkButtonVariant.text:
        return TextButton(
          onPressed: onPressed,
          style: _baseStyle(context),
          child: child,
        );
    }
  }
}
