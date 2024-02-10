import 'package:flutter/material.dart';

import '../../../../../../utils/styles.dart';


class CustomTableFooter<TResutls extends Object> extends StatelessWidget {
  const CustomTableFooter({
    super.key,
    required this.data,
    this.pageSize = 10,
    this.onPageSizeChanged,
    this.onPreviousPage,
    this.onNextPage,
    this.currentIndex = 1,
    this.lastIndex,
  });
  final List<TResutls> data;
  final int? pageSize;
  final void Function(int?)? onPageSizeChanged;
  final VoidCallback? onPreviousPage;
  final VoidCallback? onNextPage;
  final int currentIndex;
  final int? lastIndex;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 60,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            "Rows per page:",
            style: getTextStyle(
              size: 14,
              weight: FontWeight.w600,
              style: FontStyle.normal,
              color: const Color(0xff333333),
            ),
          ),
          const SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: DropdownButton<int>(
              value: pageSize,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              dropdownColor: Colors.white,
              style: getTextStyle(
                size: 14,
                weight: FontWeight.w400,
                style: FontStyle.normal,
                color: const Color(0xff333333),
              ),
              underline: Container(
                height: 2,
                color: const Color(0xffe0e0e0),
              ),
              onChanged: onPageSizeChanged,
              items: <int>[10, 20, 50, 100]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const VerticalDivider(
            width: 1.5,
            color: Color(0xffe0e0e0),
            indent: 15,
            endIndent: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "$currentIndex-${lastIndex ?? pageSize} of ${data.length}",
            style: getTextStyle(
              size: width >= 400 ? 14 : 12,
              weight: FontWeight.w600,
              style: FontStyle.normal,
              color: const Color(0xff333333),
            ),
          ),
          if (width >= 400)
            const SizedBox(
              width: 5,
            ),
          const VerticalDivider(
            width: 1.5,
            color: Color(0xffe0e0e0),
            indent: 15,
            endIndent: 15,
          ),
          if (width >= 400)
            const SizedBox(
              width: 5,
            ),
          // next and previous button
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPreviousPage,
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                size: width >= 400 ? 20 : 18,
              )),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: onNextPage,
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                size: width >= 400 ? 20 : 18,
              )),
        ]));
  }
}
