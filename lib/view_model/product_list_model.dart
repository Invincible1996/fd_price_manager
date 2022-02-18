import 'package:fd_price_manager/service/api_service.dart';
import 'package:fd_price_manager/util/log.dart';
import 'package:flutter/foundation.dart';

///
/// @date: 2022/2/17 15:23
/// @author: kevin
/// @description: dart
///

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

  String assembleSelectedCount = '1';

  init() async {
    await queryCount(color: selectedColor, name: selectedProductName);
    await queryProducts(
        offset: 0, color: selectedColor, name: selectedProductName);
    await queryColors();
    await queryProductNames();
  }

  ///
  /// @desc: 查询商品的数量
  ///
  queryCount({String? name, String? color}) async {
    var count = await ApiService.queryCount(
        name: selectedProductName, color: selectedColor);
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
      final res = await ApiService.queryProducts(
          pageSize: pageSize, offset: offset, color: color, name: name);
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
  addAssembleProducts() {
    var assembleProduct = {};

    assembleProduct
      ..['name'] = assembleSelectedProductName
      ..['color'] = assembleSelectedColor
      ..['discount'] = assembleSelectedDiscount
      ..['count'] = assembleSelectedCount
      ..['price'] = 12.00
      ..['totalPrices'] = ((double.parse(assembleSelectedCount)) *
              (1 - assembleSelectedDiscount / 100) *
              12.00)
          .toStringAsFixed(2)
      ..['discountPrice'] =
          ((12.00 * (1 - assembleSelectedDiscount / 100))).toStringAsFixed(2)
      ..['discountTotalPrices'] =
          ((12.00 * (1 - assembleSelectedDiscount / 100)) *
                  (double.parse(assembleSelectedCount)))
              .toStringAsFixed(2);

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
}
