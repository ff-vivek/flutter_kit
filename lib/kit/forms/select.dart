import 'package:flutter/material.dart';
import 'input.dart';

/// Represents an option in a UkSelect
class UkOption<T> {
  const UkOption(this.label, this.value, {this.icon});
  final String label;
  final T value;
  final IconData? icon;
}

/// A theme-aware select (dropdown) field.
class UkSelect<T> extends StatelessWidget {
  const UkSelect({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.helperText,
    this.size = UkFieldSize.medium,
    this.enabled = true,
    this.validator,
  });

  final List<UkOption<T>> options;
  final T? value;
  final void Function(T?)? onChanged;
  final String? label;
  final String? hint;
  final String? helperText;
  final UkFieldSize size;
  final bool enabled;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      validator: validator,
      onChanged: enabled ? onChanged : null,
      items: options
          .map((o) => DropdownMenuItem<T>(
                value: o.value,
                child: Row(
                  children: [
                    if (o.icon != null) ...[
                      Icon(o.icon, size: 18, color: cs.primary),
                      const SizedBox(width: 8),
                    ],
                    Flexible(child: Text(o.label)),
                  ],
                ),
              ))
          .toList(),
      style: UkFieldStyles.textStyle(context, size),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        isDense: true,
        contentPadding: UkFieldStyles.contentPadding(size),
        border: UkFieldStyles.outline(context),
        enabledBorder: UkFieldStyles.outline(context),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.3), width: 1),
        ),
        fillColor: cs.surface,
        filled: true,
      ),
    );
  }
}
