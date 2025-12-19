import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../forms/input.dart';

/// Sizes for UkSearch widgets
enum UkSearchSize { small, medium, large }

/// A compact, theme-aware search bar with leading search icon and optional clear action.
class UkSearchBar extends StatefulWidget {
  const UkSearchBar({
    super.key,
    this.controller,
    this.hint = 'Search…',
    this.size = UkSearchSize.medium,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String hint;
  final UkSearchSize size;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<UkSearchBar> createState() => _UkSearchBarState();
}

class _UkSearchBarState extends State<UkSearchBar> {
  late final TextEditingController _controller = widget.controller ?? TextEditingController();

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = switch (widget.size) {
      UkSearchSize.small => UkFieldSize.small,
      UkSearchSize.medium => UkFieldSize.medium,
      UkSearchSize.large => UkFieldSize.large,
    };

    final cs = Theme.of(context).colorScheme;
    return _SearchShell(
      height: UkFieldStyles.height(size),
      child: TextField(
        controller: _controller,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: UkFieldStyles.textStyle(context, size),
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hint,
          contentPadding: UkFieldStyles.contentPadding(size),
          prefixIcon: Icon(Icons.search, color: cs.primary),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: 'Clear',
                icon: Icon(Icons.close_rounded, color: cs.onSurfaceVariant),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  _controller.clear();
                  widget.onChanged?.call('');
                },
              );
            },
          ),
          border: UkFieldStyles.outline(context),
          enabledBorder: UkFieldStyles.outline(context),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: cs.primary, width: 1.5),
          ),
          fillColor: cs.surface,
          filled: true,
        ),
      ),
    );
  }
}

/// Autocomplete search with a dropdown suggestion menu.
///
/// Generic over option type [T]. Provide [options] and [displayStringForOption].
class UkSearchAutocomplete<T extends Object> extends StatelessWidget {
  const UkSearchAutocomplete({
    super.key,
    required this.options,
    required this.displayStringForOption,
    this.onSelected,
    this.hint = 'Search…',
    this.size = UkSearchSize.medium,
  });

  final List<T> options;
  final String Function(T) displayStringForOption;
  final ValueChanged<T>? onSelected;
  final String hint;
  final UkSearchSize size;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fieldSize = switch (size) {
      UkSearchSize.small => UkFieldSize.small,
      UkSearchSize.medium => UkFieldSize.medium,
      UkSearchSize.large => UkFieldSize.large,
    };

    return RawAutocomplete<T>(
      optionsBuilder: (text) {
        final q = text.text.toLowerCase();
        if (q.isEmpty) return options.take(0);
        return options.where((o) => displayStringForOption(o).toLowerCase().contains(q));
      },
      displayStringForOption: displayStringForOption,
      onSelected: onSelected,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return _SearchShell(
          height: UkFieldStyles.height(fieldSize),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            onSubmitted: (_) => onFieldSubmitted(),
            style: UkFieldStyles.textStyle(context, fieldSize),
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              contentPadding: UkFieldStyles.contentPadding(fieldSize),
              prefixIcon: Icon(Icons.search, color: cs.primary),
              border: UkFieldStyles.outline(context),
              enabledBorder: UkFieldStyles.outline(context),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: cs.primary, width: 1.5),
              ),
              fillColor: cs.surface,
              filled: true,
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            elevation: 0,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260, minWidth: 220),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 6),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  final label = displayStringForOption(option);
                  return InkWell(
                    onTap: () => onSelected(option),
                    splashFactory: NoSplash.splashFactory,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: cs.primary, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              label,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SearchShell extends StatelessWidget {
  const _SearchShell({required this.child, required this.height});
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
