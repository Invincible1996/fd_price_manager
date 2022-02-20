///
/// @date: 2022/2/14 16:41
/// @author: kevin
/// @description: dart
///
import '../util/list_extension.dart';
import '../util/log.dart';
import 'database_helper.dart';

class ApiService {
  ///
  ///
  /// @desc
  ///
  static Future<int> queryCount({String? color, String? name}) async {
    String colorCondition = color == '全部' ? 'color in${(await queryColors()).transformToSQL()}' : 'color = \'$color\'';

    String nameCondition = name == '全部' ? 'name in${(await queryProductNames()).transformToSQL()}' : 'name = \'$name\'';

    List list = await DatabaseHelper().db.rawQuery(
          '''SELECT COUNT(*) FROM product'''
          ''' WHERE $colorCondition AND $nameCondition''',
        );

    log(list);

    return list[0]['COUNT(*)'];
  }

  ///
  /// @des 查询所有商品
  ///
  ///
  static Future<List<Map>> queryProducts({
    int pageSize = 20,
    int offset = 0,
    String? color,
    String? name,
  }) async {
    String colorCondition = color == '全部' ? 'color in${(await queryColors()).transformToSQL()}' : 'color = \'$color\'';

    String nameCondition = name == '全部' ? 'name in${(await queryProductNames()).transformToSQL()}' : 'name = \'$name\'';

    log(colorCondition);
    log(nameCondition);

    List<Map> list = await DatabaseHelper().db.rawQuery(
      '''SELECT * FROM product 
      WHERE
      $colorCondition
      and 
      $nameCondition
      limit $pageSize offset(${offset * pageSize});''',
    );
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
  static Future<List<String>> queryColors() async {
    List list = await DatabaseHelper().db.rawQuery('select distinct color from product');
    log(list);
    return list.map<String>((e) => e['color']).toList()..insert(0, '全部');
  }

  ///
  /// @查询所有商品名称
  ///
  static Future<List<String>> queryProductNames() async {
    List list = await DatabaseHelper().db.rawQuery('select distinct name from product');
    log(list.length);
    return list.map<String>((e) => e['name']).toList()..insert(0, '全部');
  }
}
