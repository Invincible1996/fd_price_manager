///
/// @date: 2022/2/14 13:44
/// @author: kevin
/// @description: dart
import 'dart:ui';

import 'package:fd_price_manager/service/excel_service.dart';
import 'package:fd_price_manager/util/dialog_util.dart';
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

class _AssemblePricePageState extends State<AssemblePricePage>
    with AutomaticKeepAliveClientMixin {
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
        tag: 'A2',
      ),
      TableColumnsModel(
        title: '规格',
        dataIndex: 'color',
        tag: 'B2',
      ),
      TableColumnsModel(
        title: '数量',
        dataIndex: 'count',
        tag: 'C2',
      ),
      TableColumnsModel(
        title: '折扣',
        dataIndex: 'discount',
        tag: 'D2',
      ),
      TableColumnsModel(
        title: '单价',
        dataIndex: 'price',
        tag: 'E2',
      ),
      TableColumnsModel(
        title: '合计',
        dataIndex: 'totalPrices',
        tag: 'F2',
      ),
      TableColumnsModel(
        title: '单价(折扣)',
        dataIndex: 'discountPrice',
        tag: 'G2',
      ),
      TableColumnsModel(
        title: '合计(折扣)',
        dataIndex: 'discountTotalPrices',
        tag: 'H2',
      ),
      TableColumnsModel(
        title: '操作',
        dataIndex: 'action',
        builder: (item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('更新数据'),
                            content: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: '数量',
                                      isDense: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MColors.primaryColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.teal,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: '折扣',
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MColors.primaryColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.teal,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(70, 45),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('取消'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(70, 45),
                                ),
                                onPressed: () {
                                  Provider.of<ProductListModel>(context,
                                          listen: false)
                                      .removeAssembleProducts(item);
                                  Navigator.of(context).pop();
                                },
                                child: Text('确定'),
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text('编辑')),
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
                                  Provider.of<ProductListModel>(context,
                                          listen: false)
                                      .removeAssembleProducts(item);
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
    super.build(context);
    return Consumer<ProductListModel>(builder: (context, model, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            '商品组合',
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
                      defaultValue: '五孔插',
                      title: '名称',
                      onItemSelected: (String value) =>
                          model.assembleSelectedProductName = value,
                      options: model.productNames
                          .where((element) => element != '全部')
                          .toList(),
                    ),
                    SizedBox(width: 20),
                    CustomSelect<String>(
                      defaultValue: 'A7',
                      title: '颜色',
                      onItemSelected: (String value) =>
                          model.assembleSelectedColor = value,
                      options: model.colors
                          .where((element) => element != '全部')
                          .toList(),
                    ),
                    SizedBox(width: 20),
                    CustomSelect<double>(
                      defaultValue: 20,
                      title: '折扣',
                      onItemSelected: (double value) =>
                          model.assembleSelectedDiscount = value,
                      options: model.discount,
                    ),
                    SizedBox(width: 20),
                    LabelTextField(
                      width: 100,
                      label: '数量',
                      onChange: (String value) =>
                          model.assembleSelectedCount = value,
                      placeholderText: '',
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
                      onPressed: () {
                        ExcelService.export(model.assembleProducts, columns);
                      },
                      icon: Icon(Icons.exit_to_app_rounded),
                      label: Text('导出Excel'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.square(45),
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        showCustomDialog(context,
                            title: '提示', content: '确定清除吗？', onConfirm: () {
                          model.clearAssembleProducts();
                        });
                      },
                      icon: Icon(Icons.delete),
                      label: Text('清除数据'),
                    ),
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
