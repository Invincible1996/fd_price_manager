import 'package:fd_price_manager/service/database_helper.dart';

///
/// @date: 2022/2/14 16:41
/// @author: kevin
/// @description: dart
///

class ApiService {
  ///
  /// @des 查询所有商品
  ///
  ///
  static queryProducts() async {
    // List list = await DatabaseHelper().db.rawQuery('SELECT color FROM product GROUP BY color');
    List list = await DatabaseHelper().db.rawQuery('SELECT count(*) FROM product');
    print(list);
  }
}
