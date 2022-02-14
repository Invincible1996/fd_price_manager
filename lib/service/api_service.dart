import 'package:fd_price_manager/model/product_model.dart';
import 'package:fd_price_manager/service/database_helper.dart';

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

    print(list);

    return list[0]['COUNT(*)'];
  }

  ///
  /// @des 查询所有商品
  ///
  ///
  static Future<List<ProductModel>> queryProducts({int pageSize = 0}) async {
    // List list = await DatabaseHelper().db.rawQuery('SELECT color FROM product GROUP BY color');
    List list = await DatabaseHelper().db.rawQuery('SELECT * FROM product');
    if (list.isNotEmpty) {
      List<ProductModel> products =
          list.map((e) => ProductModel.fromJson(e)).toList();
      print(products.first.createTime);
      return products;
    }

    return [];
  }

  ///
  ///@desc 查询所有的颜色
  ///
  static queryColors() async {
    List list = await DatabaseHelper()
        .db
        .rawQuery('select distinct color from product');
    print(list.length);
  }

  ///
  /// @
  ///
  static queryProductNames() async {
    List list =
        await DatabaseHelper().db.rawQuery('select distinct name from product');
    print(list.length);
  }
}
