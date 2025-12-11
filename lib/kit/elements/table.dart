import 'package:flutter/material.dart';

/// A responsive, modern table component with optional striped/hover/dense styles
class UkTable extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;
  final bool striped;
  final bool hover;
  final bool dense;
  final bool bordered;

  const UkTable({
    super.key,
    required this.columns,
    required this.rows,
    this.striped = false,
    this.hover = false,
    this.dense = false,
    this.bordered = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final headingBg = cs.surfaceContainerHighest;
    final borderColor = cs.outline.withValues(alpha: 0.2);

    final dataTable = DataTable(
      headingRowColor: MaterialStatePropertyAll(headingBg),
      headingTextStyle: Theme.of(context).textTheme.labelLarge,
      dataTextStyle: Theme.of(context).textTheme.bodyMedium,
      horizontalMargin: dense ? 12 : 24,
      columnSpacing: dense ? 16 : 24,
      dataRowMinHeight: dense ? 36 : 48,
      dataRowMaxHeight: dense ? 44 : 56,
      columns: [
        for (final c in columns) DataColumn(label: Text(c)),
      ],
      rows: [
        for (int i = 0; i < rows.length; i++)
          DataRow(
            color: MaterialStateProperty.resolveWith((states) {
              if (hover && states.contains(MaterialState.hovered)) {
                return cs.primary.withValues(alpha: 0.06);
              }
              if (striped && i.isEven) {
                return cs.surfaceContainerHighest.withValues(alpha: 0.5);
              }
              return null;
            }),
            cells: [
              for (final value in rows[i]) DataCell(Text(value)),
            ],
          ),
      ],
      dividerThickness: bordered ? 1 : 0.8,
      border: bordered
          ? TableBorder(
              horizontalInside: BorderSide(color: borderColor, width: 1),
              verticalInside: BorderSide(color: borderColor, width: 1),
              top: BorderSide(color: borderColor, width: 1),
              left: BorderSide(color: borderColor, width: 1),
              right: BorderSide(color: borderColor, width: 1),
              bottom: BorderSide(color: borderColor, width: 1),
            )
          : null,
      showBottomBorder: !bordered,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: bordered ? Border.all(color: borderColor, width: 1) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: dataTable,
        ),
      ),
    );
  }
}
