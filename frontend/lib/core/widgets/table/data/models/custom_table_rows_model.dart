import 'package:flutter/material.dart';
import '../../../../../utils/styles.dart';
import 'custom_table_columns_model.dart';

abstract class BaseableRow<TType extends Object> {
  TType item;
  int index;
  bool isSelected;
  void Function(bool?)? selectRow;
  BaseableRow({
    required this.item,
    required this.index,
    this.isSelected = false,
    this.selectRow,
  });
  Widget buildCell(TType item, int columnIndex, {bool rowsSelectable = false, required List<CustomTableColumn> columns});
}

class CustomTableRow<TType extends Object> extends BaseableRow {
  CustomTableRow({
    required Object item,
    required int index,
    bool isSelected = false,
    void Function(bool?)? selectRow,
  }) : super(
          item: item,
          index: index,
          isSelected: isSelected,
          selectRow: selectRow,
        );

  @override
  Widget buildCell(Object item, int columnIndex,
      {bool rowsSelectable = false,required List<CustomTableColumn> columns}) {
    Widget rowItem = Container(
      height: 52,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffe0e0e0),
            width: 1,
          ),
        ),
      ),
      child: Ink(
        padding: EdgeInsets.zero,
        color: isSelected ? primaryColor.withOpacity(.3) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (rowsSelectable)
              if (rowsSelectable)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    width: 40,
                    child: Checkbox(
                        value: isSelected,
                        tristate: true,
                        onChanged: selectRow),
                  ),
                ),
            ...columns.map((column) => column.width == null
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: column.isNumeric ?? false
                            ? Alignment.center
                            : Alignment.centerLeft,
                        heightFactor: null,
                        child: column.buildCell(item, index),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: column.width!,
                      child: Align(
                        alignment: column.isNumeric ?? false
                            ? Alignment.center
                            : Alignment.centerLeft,
                        heightFactor: null,
                        child: column.buildCell(item, index),
                      ),
                    ),
                  ))
          ],
        ),
      ),
    );

    return rowItem;
  }
}
