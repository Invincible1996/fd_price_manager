import 'package:fd_price_manager/service/api_service.dart';
import 'package:flutter/foundation.dart';

///
/// @date: 2022/2/17 15:23
/// @author: kevin
/// @description: dart
///

class ProductListModel with ChangeNotifier {
  List<Map> _products = [];

  List<String> colors = [];

  List<String> productNames = [];

  int totalCount = 0;

  final int pageSize = 20;

  int offset = 0;

  List<Map> get products => _products;

  String? selectedColor = '全部';

  String? selectedProductName = '全部';

  init() async {
    await queryCount(color: selectedColor, name: selectedProductName);
    await queryProducts(offset: 0, color: selectedColor, name: selectedProductName);
    await queryColors();
    await queryProductNames();
  }

  queryCount({String? name, String? color}) async {
    var count = await ApiService.queryCount(name: selectedProductName, color: selectedColor);
    totalCount = count;
    notifyListeners();
  }

  ///
  ///
  ///
  setOffset(int offset) {
    this.offset = offset;
    notifyListeners();
  }

  ///
  ///
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
    if (result != null) {
      colors
        ..clear()
        ..addAll(result);
      notifyListeners();
    }
  }

  ///
  /// @param [offset]
  /// @param [color]
  /// @description:
  ///
  queryProducts({required int offset, String? color, String? name}) async {
    try {
      await queryCount(name: selectedProductName, color: selectedColor);
      final res = await ApiService.queryProducts(pageSize: pageSize, offset: offset, color: color, name: name);
      _products.clear();
      _products.addAll(res);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
