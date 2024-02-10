import 'package:flutter/material.dart';
import '../../../../../../utils/styles.dart';
import '../../../data/models/custom_table_columns_model.dart';
import '../../../data/models/custom_table_rows_model.dart';

class CutomTableRows<TResult extends Object> extends StatelessWidget {
  CutomTableRows({
    super.key,
    required this.columns,
    required this.rows,
    this.rowsSelectable = false,
    this.isLoading = false,
  });
  final List<CustomTableColumn<TResult>> columns;
  final bool rowsSelectable;
  final bool isLoading;
  final List<CustomTableRow<TResult>> rows;
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isLoading ? .3 : 1,
      child: DefaultTextStyle(
          overflow: TextOverflow.ellipsis,
          style: getTextStyle(
            size: 14,
            weight: FontWeight.w400,
            style: FontStyle.normal,
            color: const Color(0xff333333),
          ),
          child:rows.isEmpty? const Center(child: Text('No Data Found'),): _build(context, rows)),
           
    );
  }

  Widget _build(BuildContext context, List<CustomTableRow<TResult>> rows) {
    return ListView(
      shrinkWrap: true,
      controller: _scrollController,
      children: [
        ...rows.map((row) {
          return row.buildCell(row.item, row.index,
              rowsSelectable: rowsSelectable, columns: columns);
        })
      ],
    );
  }
}
