///
/// @date: 2022/2/14 13:44
/// @author: kevin
/// @description: dart
import 'dart:ui';

import 'package:fd_price_manager/view_model/product_list_model.dart';
import 'package:fd_price_manager/widget/custom_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../m_colors.dart';
import '../model/table_columns_model.dart';
import '../widget/custom_table.dart';

class AssemblePricePage extends StatefulWidget {
  const AssemblePricePage({Key? key}) : super(key: key);

  @override
  _AssemblePricePageState createState() => _AssemblePricePageState();
}

class _AssemblePricePageState extends State<AssemblePricePage> {
  final List<TableColumnsModel> columns = [
    TableColumnsModel(
      title: '#',
      dataIndex: 'id',
    ),
    TableColumnsModel(
      title: '商品名称',
      dataIndex: 'name',
    ),
    TableColumnsModel(
      title: '规格',
      dataIndex: 'color',
    ),
    TableColumnsModel(
      title: '单价',
      dataIndex: 'price',
    ),
    TableColumnsModel(
      title: '数量',
      dataIndex: 'count',
    ),
    TableColumnsModel(
      title: '折扣',
      dataIndex: 'discount',
    ),
    TableColumnsModel(
      title: '合计',
      dataIndex: 'total',
    ),
    TableColumnsModel(
      title: '操作',
      dataIndex: 'action',
      builder: (item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {}, child: const Text('编辑')),
            TextButton(onPressed: () {}, child: const Text('删除')),
          ],
        );
      },
    ),
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListModel>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            'AssemblePricePage',
            style: TextStyle(color: MColors.textColor),
          ),
        ),
        body: Container(
          color: MColors.bgColor,
          child: CustomTable(
            isShowPagination: false,
            data: model.assembleProducts,
            totalCount: 0,
            pageSize: 0,
            onTapPageIndex: (int value) {},
            onTapPrevious: () {},
            onTapNext: () {},
            selectedIndex: 0,
            columns: columns,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: '添加商品',
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 500,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '新增',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomSelect<String>(
                                        defaultValue: '五孔插',
                                        title: '名称',
                                        onItemSelected: (String value) {},
                                        options: model.productNames,
                                      ),
                                      CustomSelect<String>(
                                        defaultValue: '10',
                                        title: '折扣',
                                        onItemSelected: (String value) {},
                                        options: [
                                          "10",
                                          "20",
                                          "30",
                                          "40",
                                          "50",
                                          "60",
                                          "70",
                                          "80",
                                          "90"
                                        ],
                                      ),
                                      CustomSelect<String>(
                                        defaultValue: 'A7',
                                        title: '颜色',
                                        onItemSelected: (String value) {},
                                        options: model.colors,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('确定')),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('取消'))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
