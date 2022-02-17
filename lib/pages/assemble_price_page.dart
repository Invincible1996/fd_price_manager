///
/// @date: 2022/2/14 13:44
/// @author: kevin
/// @description: dart
import 'package:fd_price_manager/view_model/product_list_model.dart';
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
      title: '单价',
      dataIndex: 'price',
    ),
    TableColumnsModel(
      title: '规格',
      dataIndex: 'color',
    ),
    TableColumnsModel(
      title: '规格',
      dataIndex: 'color',
      builder: (item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {}, child: Text('编辑')),
            TextButton(onPressed: () {}, child: Text('删除')),
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
      body: Consumer<ProductListModel>(
        builder: (contenx, model, _) {
          return Container(
            color: MColors.bgColor,
            child: CustomTable(
              isShowPagination: false,
              data: model.products,
              totalCount: 0,
              pageSize: 0,
              onTapPageIndex: (int value) {},
              onTapPrevious: () {},
              onTapNext: () {},
              selectedIndex: 0,
              columns: columns,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
