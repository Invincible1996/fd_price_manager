///
/// @date: 2022/2/14 13:42
/// @author: kevin
/// @description: dart
import 'package:flutter/material.dart';

import '../m_colors.dart';
import '../model/table_columns_model.dart';
import '../service/api_service.dart';
import '../service/database_helper.dart';
import '../service/excel_service.dart';
import '../util/log.dart';
import '../widget/custom_select.dart';
import '../widget/custom_table.dart';
import '../widget/select.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> with AutomaticKeepAliveClientMixin {
  List<Map> _products = [];
  int _totalCount = 0;
  final int _pageSize = 20;
  int _offset = 0;

  final List<TableColumnsModel> columns = [
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
      var count = await ApiService.getCount();
      var products = await ApiService.queryProducts(pageSize: _pageSize, offset: _offset);

      setState(() {
        _products = products;
        _totalCount = count;
      });

      ApiService.queryColors();
      ApiService.queryProductNames();
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
      body: Container(
        color: MColors.bgColor,
        child: Column(
          children: [
            Container(
              height: 120,
              padding: const EdgeInsets.all(10),
              // margin: const EdgeInsets.symmetric(
              //   horizontal: 16,
              //   vertical: 10,
              // ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // LabelTextField(
                      //   onChange: (String text) {},
                      //   placeholderText: '请输入商品名称',
                      //   label: '名称',
                      // ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      // LabelTextField(
                      //   onChange: (String text) {},
                      //   placeholderText: '请输入商品规格',
                      //   label: '规格',
                      // ),
                      // SizedBox(
                      //   width: 10,
                      // ),

                      CustomSelect<String>(
                        title: '颜色',
                        onItemSelected: (String value) {},
                        options: const ['红色', '绿色', '蓝色', '黄色', '紫色'],
                      ),
                      const SizedBox(width: 20),
                      CustomSelect<int>(
                        width: 120,
                        selectType: SelectType.search,
                        onSearch: (String text) async {},
                        options: const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                        title: '规格',
                        onItemSelected: (String value) {},
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () {},
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
                selectedIndex: _offset,
                columns: columns,
                data: _products,
                totalCount: _totalCount,
                pageSize: _pageSize,
                onTapNext: () async {
                  var totalGroupSize = (_totalCount / _pageSize).ceilToDouble().toInt();
                  if (_offset == totalGroupSize - 1) {
                    return;
                  }
                  var products = await ApiService.queryProducts(
                    offset: _offset + 1,
                    pageSize: _pageSize,
                  );
                  setState(() {
                    _offset += 1;
                    _products = products;
                  });
                },
                onTapPrevious: () async {
                  if (_offset == 0) {
                    return;
                  }
                  var products = await ApiService.queryProducts(
                    offset: _offset - 1,
                    pageSize: _pageSize,
                  );
                  setState(() {
                    _offset -= 1;
                    _products = products;
                  });
                },
                onTapPageIndex: (index) async {
                  log(index);
                  var products = await ApiService.queryProducts(
                    offset: index,
                    pageSize: _pageSize,
                  );
                  setState(() {
                    _offset = index;
                    _products = products;
                  });
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
