///
/// @date: 2022/2/14 13:42
/// @author: kevin
/// @description: dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../m_colors.dart';
import '../model/table_columns_model.dart';
import '../service/database_helper.dart';
import '../service/excel_service.dart';
import '../util/dialog_util.dart';
import '../util/log.dart';
import '../view_model/product_list_model.dart';
import '../widget/custom_select.dart';
import '../widget/custom_table.dart';
import '../widget/select.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> with AutomaticKeepAliveClientMixin {
  List<TableColumnsModel> columns = [];

  @override
  initState() {
    super.initState();
    columns = [
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
        title: '操作',
        dataIndex: 'color',
        builder: (index, item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: Text('编辑')),
              TextButton(
                  onPressed: () {
                    showCustomDialog(context, title: '提示', content: '确认删除该商品？', onConfirm: () {});
                  },
                  child: Text('删除')),
            ],
          );
        },
      ),
    ];
    DatabaseHelper().initial().then((res) async {
      Provider.of<ProductListModel>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final productModel = Provider.of<ProductListModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          '商品价格列表',
          style: TextStyle(color: MColors.textColor),
        ),
        centerTitle: false,
      ),
      body: Container(
        color: MColors.bgColor,
        child: Column(
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomSelect<String>(
                        defaultValue: '全部',
                        title: '颜色',
                        onItemSelected: (String value) async {
                          productModel.selectedColor = value;
                          await productModel.queryProducts(
                            offset: 0,
                            color: productModel.selectedColor,
                            name: productModel.selectedProductName,
                          );
                        },
                        options: productModel.colors,
                      ),
                      const SizedBox(width: 20),
                      CustomSelect<String>(
                        defaultValue: '全部',
                        width: 150,
                        menuType: MenuType.wrap,
                        // selectType: SelectType.search,
                        onSearch: (String text) async {},
                        options: productModel.productNames,
                        title: '名称',
                        onItemSelected: (String value) async {
                          productModel.selectedProductName = value;
                          await productModel.queryProducts(
                            offset: 0,
                            color: productModel.selectedColor,
                            name: productModel.selectedProductName,
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ExcelService.import();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 45),
                        ),
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text('导入商品数据'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: const Size(120, 45),
                        ),
                        icon: const Icon(Icons.dangerous),
                        label: const Text('清空商品数据'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Selector<ProductListModel, Tuple4<List<Map>, int, int, int>>(
                selector: (context, model) => Tuple4(
                  model.products,
                  model.offset,
                  model.totalCount,
                  model.pageSize,
                ),
                builder: (context, model, _) {
                  log('build========${model.item1}');
                  return CustomTable(
                    data: model.item1,
                    selectedIndex: model.item2,
                    totalCount: model.item3,
                    pageSize: model.item4,
                    columns: columns,
                    onTapNext: () async {
                      print('$model.item2');

                      var totalGroupSize = (productModel.totalCount / productModel.pageSize).ceilToDouble().toInt();
                      if (productModel.offset == totalGroupSize - 1) {
                        return;
                      }
                      productModel.offset++;
                      productModel.queryProducts(
                        offset: productModel.offset,
                        color: productModel.selectedColor,
                        name: productModel.selectedProductName,
                      );
                    },
                    onTapPrevious: () async {
                      if (productModel.offset == 0) {
                        return;
                      }
                      productModel.offset--;
                      productModel.queryProducts(
                        offset: productModel.offset,
                        color: productModel.selectedColor,
                        name: productModel.selectedProductName,
                      );
                    },
                    onTapPageIndex: (index) async {
                      // log(index);
                      productModel.offset = index;
                      productModel.queryProducts(
                        offset: productModel.offset,
                        color: productModel.selectedColor,
                        name: productModel.selectedProductName,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
