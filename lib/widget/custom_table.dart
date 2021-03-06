///
/// @date: 2022/2/14 14:39
/// @author: kevin
/// @description: dart
///
import 'package:flutter/material.dart';

import '../m_colors.dart';
import '../model/table_columns_model.dart';

class CustomTable extends StatelessWidget {
  final List<TableColumnsModel> columns;
  final List<Map> data;
  final int totalCount;
  final int pageSize;
  final int selectedIndex;
  final Function(int) onTapPageIndex;
  final Function() onTapPrevious;
  final Function() onTapNext;
  final bool isShowPagination;

  const CustomTable({
    Key? key,
    required this.columns,
    required this.data,
    required this.totalCount,
    required this.pageSize,
    required this.onTapPageIndex,
    required this.onTapPrevious,
    required this.onTapNext,
    required this.selectedIndex,
    this.isShowPagination = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(50),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: MColors.tableHeaderBgcolor,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: MColors.divideColor,
                  ),
                ),
              ),
              children: columns
                  .map(
                    (e) => Container(
                      height: 40,
                      color: MColors.tableHeaderBgcolor,
                      alignment: Alignment.center,
                      child: Text(
                        '${e.title}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        Expanded(
          child: data.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber_outlined),
                      Text(
                        '????????????',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: [
                    Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(50),
                      },
                      children: data
                          .asMap()
                          .map(
                            (key1, item) => MapEntry(
                              key1,
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: MColors.divideColor,
                                    ),
                                  ),
                                ),
                                children: columns
                                    .asMap()
                                    .map(
                                      (key, e) => MapEntry(
                                        key,
                                        Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          child: (e.builder?.call(key1, item)) ??
                                              Text(e.dataIndex == 'index' ? '${key1 + 1}' : '${item[e.dataIndex]}'),
                                        ),
                                      ),
                                    )
                                    .values
                                    .toList(),
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ],
                ),
        ),
        isShowPagination
            ? Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: MColors.divideColor,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MColors.divideColor),
                        ),
                        child: const Icon(Icons.keyboard_arrow_left_rounded, size: 22),
                      ),
                      onTap: () {
                        onTapPrevious();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildPageIndex(),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MColors.divideColor),
                        ),
                        child: const Icon(Icons.keyboard_arrow_right_rounded, size: 22),
                      ),
                      onTap: () {
                        onTapNext();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     // width: 100
                    //     padding: const EdgeInsets.all(4),
                    //     height: 30,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(
                    //       width: 1,
                    //       color: MColors.divideColor,
                    //       // color: MColors.primaryColor,
                    //     )),
                    //     child: Row(
                    //       children: const [
                    //         Text('10???/???'),
                    //         Icon(Icons.arrow_drop_down),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  ///
  ///
  ///
  ///
  _buildPageIndex() {
    var totalGroupSize = (totalCount / pageSize).ceilToDouble().toInt();
    return Wrap(
      spacing: 10,
      children: List.generate(
        totalGroupSize,
        (index) => InkWell(
          onTap: () {
            onTapPageIndex(index);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: index == selectedIndex ? MColors.primaryColor : MColors.divideColor,
              ),
            ),
            width: 30,
            height: 30,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: index == selectedIndex ? MColors.primaryColor : MColors.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
