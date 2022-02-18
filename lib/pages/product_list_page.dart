///
/// @date: 2022/2/14 13:42
/// @author: kevin
/// @description: dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../m_colors.dart';
import '../model/table_columns_model.dart';
import '../service/database_helper.dart';
import '../service/excel_service.dart';
import '../util/log.dart';
import '../view_model/product_list_model.dart';
import '../widget/custom_select.dart';
import '../widget/custom_table.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> with AutomaticKeepAliveClientMixin {
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
      title: '操作',
      dataIndex: 'color',
      builder: (item) {
        log(item);
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

    DatabaseHelper().initial().then((res) async {
      Provider.of<ProductListModel>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: Text(
          'ProductListPage',
          style: TextStyle(color: MColors.textColor),
        ),
        centerTitle: false,
      ),
      body: Consumer<ProductListModel>(builder: (contex, model, _) {
        print(model.products);
        return Container(
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
                            model.selectedColor = value;
                            await model.queryProducts(
                              offset: 0,
                              color: model.selectedColor,
                              name: model.selectedProductName,
                            );
                          },
                          options: model.colors,
                        ),
                        const SizedBox(width: 20),
                        CustomSelect<String>(
                          defaultValue: '全部',
                          width: 150,
                          // selectType: SelectType.search,
                          onSearch: (String text) async {},
                          options: model.productNames,
                          title: '名称',
                          onItemSelected: (String value) async {
                            model.selectedProductName = value;
                            await model.queryProducts(
                              offset: 0,
                              color: model.selectedColor,
                              name: model.selectedProductName,
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 40),
                          ),
                          icon: const Icon(Icons.search_rounded),
                          label: const Text('搜索'),
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
                child: CustomTable(
                  selectedIndex: model.offset,
                  columns: columns,
                  data: model.products,
                  totalCount: model.totalCount,
                  pageSize: model.pageSize,
                  onTapNext: () async {
                    var totalGroupSize = (model.totalCount / model.pageSize).ceilToDouble().toInt();
                    if (model.offset == totalGroupSize - 1) {
                      return;
                    }
                    model.offset++;
                    model.queryProducts(
                      offset: model.offset,
                      color: model.selectedColor,
                      name: model.selectedProductName,
                    );
                  },
                  onTapPrevious: () async {
                    if (model.offset == 0) {
                      return;
                    }
                    model.offset--;
                    model.queryProducts(
                      offset: model.offset,
                      color: model.selectedColor,
                      name: model.selectedProductName,
                    );
                  },
                  onTapPageIndex: (index) async {
                    log(index);
                    model.offset = index;
                    model.queryProducts(
                      offset: model.offset,
                      color: model.selectedColor,
                      name: model.selectedProductName,
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
