import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The standard sizes for form fields
enum UkFieldSize { small, medium, large }

/// Shared field sizing and decoration helpers
class UkFieldStyles {
  static double height(UkFieldSize size) {
    switch (size) {
      case UkFieldSize.small:
        return 40;
      case UkFieldSize.medium:
        return 48;
      case UkFieldSize.large:
        return 56;
    }
  }

  static EdgeInsets contentPadding(UkFieldSize size) {
    switch (size) {
      case UkFieldSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case UkFieldSize.medium:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 12);
      case UkFieldSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
    }
  }

  static TextStyle textStyle(BuildContext context, UkFieldSize size) {
    final base = Theme.of(context).textTheme.bodyMedium!;
    switch (size) {
      case UkFieldSize.small:
        return base.copyWith(fontSize: base.fontSize != null ? base.fontSize! - 1 : 13);
      case UkFieldSize.medium:
        return base;
      case UkFieldSize.large:
        return base.copyWith(fontSize: base.fontSize != null ? base.fontSize! + 1 : 15);
    }
  }

  static InputBorder outline(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5), width: 1),
    );
  }
}

/// A modern, theme-aware text field.
///
/// - Supports sizes, helper/error text, prefix/suffix, and password toggle.
/// - Uses ColorScheme and TextTheme for consistent styling.
class UkTextField extends StatelessWidget {
  const UkTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = UkFieldSize.medium,
    this.isPassword = false,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hint;
  final String? helperText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final UkFieldSize size;
  final bool isPassword;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final effectiveController = controller;

    return _UkFieldShell(
      height: UkFieldStyles.height(size),
      child: TextFormField(
        controller: effectiveController,
        initialValue: effectiveController == null ? initialValue : null,
        enabled: enabled,
        obscureText: isPassword,
        validator: validator,
        onChanged: (v) {
          if (onChanged != null) onChanged!(v);
        },
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        minLines: minLines,
        style: UkFieldStyles.textStyle(context, size),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          isDense: true,
          contentPadding: UkFieldStyles.contentPadding(size),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: cs.primary) : null,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: cs.primary) : null,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cs.error, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cs.error, width: 1.5),
          ),
          fillColor: cs.surface,
          filled: true,
        ),
      ),
    );
  }
}

/// A multi-line text area with the same visual style as UkTextField.
class UkTextArea extends StatelessWidget {
  const UkTextArea({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.size = UkFieldSize.medium,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.minLines = 3,
    this.maxLines = 6,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hint;
  final String? helperText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final UkFieldSize size;
  final bool enabled;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    try {
      return UkTextField(
        controller: controller,
        initialValue: initialValue,
        label: label,
        hint: hint,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        size: size,
        enabled: enabled,
        validator: validator,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
      );
    } catch (e, st) {
      debugPrint('UkTextArea build error: $e\n$st');
      rethrow;
    }
  }
}

/// Internal shell for enforcing min height and rounded corners background
class _UkFieldShell extends StatelessWidget {
  const _UkFieldShell({required this.child, required this.height});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: height),
      child: child,
    );
  }
}
