import 'package:fd_price_manager/service/database_helper.dart';
import 'package:fd_price_manager/util/log.dart';

///
/// @date: 2022/2/14 16:41
/// @author: kevin
/// @description: dart
///

class ApiService {
  ///
  ///
  /// @desc
  ///
  static Future<int> getCount() async {
    List list =
        await DatabaseHelper().db.rawQuery('SELECT COUNT(*) FROM product');

    log(list);

    return list[0]['COUNT(*)'];
  }

  ///
  /// @des 查询所有商品
  ///
  ///
  static Future<List<Map>> queryProducts(
      {int pageSize = 0, int offset = 0}) async {
    // List list = await DatabaseHelper().db.rawQuery('SELECT color FROM product GROUP BY color');
    List<Map> list = await DatabaseHelper().db.rawQuery(
        'SELECT * FROM product limit $pageSize offset(${offset * pageSize})');
    // if (list.isNotEmpty) {
    //   List<ProductModel> products = list.map((e) => ProductModel.fromJson(e)).toList();
    //   print(products.first.toJson());
    //   print(products.last.toJson());
    //   return products;
    // }

    return list;
  }

  ///
  ///@desc 查询所有的颜色
  ///
  static queryColors() async {
    List list = await DatabaseHelper()
        .db
        .rawQuery('select distinct color from product');
    log(list.length);
  }

  ///
  /// @查询所有商品名称
  ///
  static queryProductNames() async {
    List list =
        await DatabaseHelper().db.rawQuery('select distinct name from product');
    log(list.length);
  }
}
