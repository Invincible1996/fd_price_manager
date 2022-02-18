///
/// @date: 2022/2/14 13:44
/// @author: kevin
/// @description: dart
import 'dart:ui';

import 'package:fd_price_manager/view_model/product_list_model.dart';
import 'package:fd_price_manager/widget/custom_select.dart';
import 'package:fd_price_manager/widget/label_text_field.dart';
import 'package:fd_price_manager/widget/select.dart';
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

class _AssemblePricePageState extends State<AssemblePricePage> with AutomaticKeepAliveClientMixin {
  List<TableColumnsModel> columns = [];

  @override
  initState() {
    super.initState();
    columns = [
      TableColumnsModel(
        title: '#',
        dataIndex: 'index',
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
        dataIndex: 'totalPrices',
      ),
      TableColumnsModel(
        title: '操作',
        dataIndex: 'action',
        builder: (item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: const Text('编辑')),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('提示'),
                            content: Text('确定删除该条数据吗？'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('取消'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('确定'),
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text('删除')),
            ],
          );
        },
      ),
    ];
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
          child: Column(
            children: [
              Container(
                height: 120,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CustomSelect<String>(
                      menuType: MenuType.wrap,
                      width: 160,
                      defaultValue: '150W调速开关',
                      title: '名称',
                      onItemSelected: (String value) => model.assembleSelectedProductName = value,
                      options: model.productNames.where((element) => element != '全部').toList(),
                    ),
                    SizedBox(width: 20),
                    CustomSelect<String>(
                      defaultValue: 'A7',
                      title: '颜色',
                      onItemSelected: (String value) => model.assembleSelectedColor = value,
                      options: model.colors.where((element) => element != '全部').toList(),
                    ),
                    SizedBox(width: 20),
                    CustomSelect<String>(
                      defaultValue: '20',
                      title: '折扣',
                      onItemSelected: (String value) => model.assembleSelectedDiscount = value,
                      options: model.discount,
                    ),
                    SizedBox(width: 20),
                    LabelTextField(
                      label: '数量',
                      onChange: (String value) => model.assembleSelectedCount = value,
                      placeholderText: '请输入数量',
                    ),
                    Expanded(child: Container()),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.square(45),
                      ),
                      onPressed: () {
                        model.addAssembleProducts();
                      },
                      icon: Icon(Icons.add),
                      label: Text('添加'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.square(45),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.exit_to_app_rounded),
                      label: Text('导出Excel'),
                    )
                  ],
                ),
              ),
              Expanded(
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
            ],
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomSelect<String>(
                                        defaultValue: '五孔插',
                                        title: '名称',
                                        onItemSelected: (String value) => model.assembleSelectedProductName = value,
                                        options: model.productNames,
                                      ),
                                      CustomSelect<String>(
                                        defaultValue: '10',
                                        title: '折扣',
                                        onItemSelected: (String value) => model.assembleSelectedDiscount = value,
                                        options: ["10", "20", "30", "40", "50", "60", "70", "80", "90"],
                                      ),
                                      CustomSelect<String>(
                                        defaultValue: 'A7',
                                        title: '颜色',
                                        onItemSelected: (String value) => model.assembleSelectedColor = value,
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

  @override
  bool get wantKeepAlive => true;
}
