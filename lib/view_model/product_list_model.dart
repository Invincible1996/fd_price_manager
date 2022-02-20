///
/// @date: 2022/2/17 15:23
/// @author: kevin
/// @description: dart
///
import 'package:flutter/foundation.dart';

import '../service/api_service.dart';
import '../util/log.dart';

class ProductListModel with ChangeNotifier {
  // 所有商品
  List<Map> products = [];

  // 组合的商品
  List<Map> assembleProducts = [];

  List<String> colors = [];

  List<String> productNames = [];

  List<double> discount = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  int totalCount = 0;

  final int pageSize = 20;

  int offset = 0;

  String? selectedColor = '全部';

  String? selectedProductName = '全部';

  String assembleSelectedProductName = '五孔插';

  String assembleSelectedColor = 'A7';

  double assembleSelectedDiscount = 20;

  int assembleSelectedCount = 1;

  int currentItemIndex = 0;

  //编辑后的数量
  int editCount = 1;

  //编辑后的折扣
  double editDiscount = 0;

  init() async {
    await queryCount(color: selectedColor, name: selectedProductName);
    await queryProducts(offset: 0, color: selectedColor, name: selectedProductName);
    await queryColors();
    await queryProductNames();
  }

  ///
  /// @desc: 查询商品的数量
  ///
  queryCount({String? name, String? color}) async {
    var count = await ApiService.queryCount(name: selectedProductName, color: selectedColor);
    totalCount = count;
    notifyListeners();
  }

  ///
  /// @desc 查询所有商品名称
  ///
  queryProductNames() async {
    final res = await ApiService.queryProductNames();
    productNames
      ..clear()
      ..addAll(res);
    notifyListeners();
  }

  ///
  ///
  ///@description: 查询所有颜色
  ///
  queryColors() async {
    var result = await ApiService.queryColors();
    colors
      ..clear()
      ..addAll(result);
    notifyListeners();
  }

  ///
  /// @param [offset]
  /// @param [color]
  /// @description: 根据条件查询商品
  ///
  queryProducts({required int offset, String? color, String? name}) async {
    try {
      await queryCount(name: selectedProductName, color: selectedColor);
      final res = await ApiService.queryProducts(pageSize: pageSize, offset: offset, color: color, name: name);
      products.clear();
      products.addAll(res);
      notifyListeners();
    } catch (e) {
      log(e);
    }
  }

  ///
  /// @description: 新增组合商品
  ///
  addAssembleProducts() async {
    var assembleProduct = {};

    var res = await ApiService.queryProducts(name: assembleSelectedProductName, color: assembleSelectedColor);
    if (res.isEmpty) {
      return;
    }

    var price = res.first['price'];

    editCount = assembleSelectedCount;

    editDiscount = assembleSelectedDiscount;

    assembleProduct
      ..['name'] = assembleSelectedProductName
      ..['color'] = assembleSelectedColor
      ..['discount'] = assembleSelectedDiscount
      ..['count'] = assembleSelectedCount
      ..['price'] = price
      ..['totalPrices'] = (assembleSelectedCount * price).toStringAsFixed(2)
      ..['discountPrice'] = ((price * (1 - assembleSelectedDiscount / 100))).toStringAsFixed(2)
      ..['discountTotalPrices'] =
          ((price * (1 - assembleSelectedDiscount / 100)) * assembleSelectedCount).toStringAsFixed(2);

    assembleProducts.add(assembleProduct);
    log(assembleProducts);
    notifyListeners();
  }

  ///
  /// @description: 删除组合商品
  ///
  removeAssembleProducts(Map item) {
    assembleProducts.remove(item);
    log(assembleProducts);
    notifyListeners();
  }

  ///
  /// description: 清空组合商品
  ///
  clearAssembleProducts() {
    assembleProducts.clear();
    log(assembleProducts);
    notifyListeners();
  }

  /// @description: 修改商品折扣
  void updateDiscount(int index, String value) {
    log(index);
    log(value);
    editDiscount = double.parse(value);
  }

  /// @description: 修改商品数量
  void updateCount(int index, String value) {
    log(index);
    log(value);
    editCount = int.parse(value);
  }

  /// @description: 修改组合商品数量和折扣
  void updateAssembleCountAndDiscount(int index) {
    assembleProducts[index]['count'] = editCount;
    assembleProducts[index]['discount'] = editDiscount;
    assembleProducts[index]['totalPrices'] = (assembleProducts[index]['price'] * editCount).toStringAsFixed(2);
    assembleProducts[index]['discountPrice'] =
        (assembleProducts[index]['price'] * (1 - editDiscount / 100)).toStringAsFixed(2);
    assembleProducts[index]['discountTotalPrices'] =
        (assembleProducts[index]['price'] * (1 - editDiscount / 100) * editCount).toStringAsFixed(2);
    log(assembleProducts);
    notifyListeners();
  }
}
