///
/// @date: 2022/2/14 14:39
/// @author: kevin
/// @description: dart
///
import 'package:fd_price_manager/util/log.dart';
import 'package:fd_price_manager/widget/pagination.dart';
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
                        '暂无数据',
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
                                          child: (e.builder?.call(key1, item)) ?? Text(e.dataIndex == 'index' ? '${key1 + 1}' : '${item[e.dataIndex]}'),
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
            ? Pagination(
                totalPage: 100,
                onPageChanged: (currentPage, pageSize) {
                  log(currentPage);
                  log(pageSize);
                },
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
