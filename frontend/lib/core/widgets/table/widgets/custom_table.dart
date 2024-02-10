import 'package:flutter/material.dart';
import '../../../../config/responsiveness/responsive.dart';
import '../data/models/custom_table_columns_model.dart';
import '../data/models/custom_table_rows_model.dart';
import '../src/widgets/components/custom_table_column_headers.dart';
import '../src/widgets/components/custom_table_footer.dart'; 
import '../src/widgets/components/custom_table_rows.dart';
import '../src/widgets/custom_table_head.dart';

class CustomTable<TResult extends Object> extends StatefulWidget {
  const CustomTable(
      {
   
      required this.data,
      this.header,
    required this.rows,
      this.width,
      required this.columns,
      this.rowsSelectable = false,
      this.showColumnHeadersAtFooter = false,
      this.isAllRowsSelected = false,
      this.selectAllRows,
      this.currentIndex = 1,
      this.lastIndex,
      super.key, this.pageSize, this.onPageSizeChanged, this.onPreviousPage, this.onNextPage});
  final List<TResult> data;
  final Widget? header;
  final List<CustomTableColumn<TResult>> columns;
  final bool rowsSelectable;
  final bool showColumnHeadersAtFooter;
  final double? width;
  final bool isAllRowsSelected;
  final void Function(bool?)? selectAllRows;
  final List<CustomTableRow<TResult>> rows;
   final int? pageSize;
  final void Function(int?)? onPageSizeChanged;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;
  final int currentIndex;
   final int? lastIndex;

  @override
  State<CustomTable<TResult>> createState() =>
      _CustomTableState<TResult>();
}

class _CustomTableState<TResult extends Object>
    extends State<CustomTable<TResult>> {
  final _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cummulatedWidth = widget.columns.fold(
        0,
        (previousValue, element) => element.width != null
            ? previousValue + element.width!.ceil()
            : previousValue);
    var width = (300 *
            widget.columns.where((element) => element.width == null).length) +
        cummulatedWidth.toDouble();

    return LayoutBuilder(builder: (context, constraints) {
      // pad the width of the table to the width of the screen is the table is smaller than the screen
      if (constraints.maxWidth > width) {
        width = constraints.maxWidth;
      }
      return Column(children: [
        if(widget.header != null)
        CustomTableHead(
          header: widget.header,
        ),
        Expanded(
            child: Scrollbar(
          controller: _horizontalScrollController,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            controller: _horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: widget.width ??
                      (ResponsiveUI(context: context).isMobile()
                          ? constraints.maxWidth * 5
                          : ResponsiveUI(context: context).isTablet()
                              ? constraints.maxWidth * 2
                              : width),
                  child: Column(
                    children: [
                      CustomTableColumnHeader<TResult>(
                        columns: widget.columns,
                        data: widget.data,
                        rowsSelectable: widget.rowsSelectable,
                        isAllRowsSelected: widget.isAllRowsSelected,
                        selectAllRows: widget.selectAllRows,
                      ),
                      Divider(height: 0, color: Theme.of(context).dividerColor),
                      // show rows
                      Expanded(
                          child: widget.data.isNotEmpty
                              ? CutomTableRows<TResult>(
                                  columns: widget.columns,
                                  rowsSelectable: widget.rowsSelectable,                              
                                  rows: widget.rows,
                                )
                              : const Center(
                                  child: Text('No Data Found'),
                                )),

                      if (widget.showColumnHeadersAtFooter)
                        CustomTableColumnHeader<TResult>(
                          columns: widget.columns,
                          data: widget.data,
                          rowsSelectable: false,
                          isAllRowsSelected: false,
                          selectAllRows: null,
                          
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
        CustomTableFooter<TResult>(
          data: widget.data,
          pageSize: widget.pageSize,
          onPageSizeChanged: widget.onPageSizeChanged,
          onPreviousPage: widget.onPreviousPage,
          onNextPage: widget.onNextPage,
          currentIndex: widget.currentIndex,
          lastIndex: widget.lastIndex,
          
        ),
      ]);
    });
  }
}
