///
/// @date: 2022/2/14 13:42
/// @author: kevin
/// @description: dart
import 'package:fd_price_manager/m_colors.dart';
import 'package:fd_price_manager/model/product_model.dart';
import 'package:fd_price_manager/service/api_service.dart';
import 'package:fd_price_manager/service/database_helper.dart';
import 'package:fd_price_manager/service/excel_service.dart';
import 'package:fd_price_manager/widget/label_text_field.dart';
import 'package:flutter/material.dart';

import 'widget/custom_table.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<ProductModel> _products = [];

  @override
  initState() {
    super.initState();
    DatabaseHelper().initial().then((res) async {
      var products = await ApiService.queryProducts();

      setState(() {
        _products = products;
      });

      ApiService.queryColors();
      ApiService.queryProductNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductListPage'),
        centerTitle: false,
      ),
      body: Container(
        color: MColors.bgColor,
        child: Column(
          children: [
            Container(
              height: 120,
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LabelTextField(
                        onChange: (String text) {},
                        placeholderText: '请输入商品名称',
                        label: '名称',
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      LabelTextField(
                        onChange: (String text) {},
                        placeholderText: '请输入商品规格',
                        label: '规格',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(50, 40),
                        ),
                        icon: Icon(Icons.search_rounded),
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
                        icon: Icon(Icons.cloud_upload),
                        label: const Text('导入商品数据'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 45),
                        ),
                        icon: Icon(Icons.cloud_upload),
                        label: const Text('导入商品数据'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomTable(
                  header: ['商品名称', '单价', '规格', '操作'],
                  data: _products,
                ),
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
}
