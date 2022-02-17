import 'package:fd_price_manager/util/log.dart';

///
/// @date: 2022/2/17 17:44
/// @author: kevin
/// @description: dart
///
///
extension ListExtension on List {
  ///
  /// @description: List转换String
  /// @param {type}
  /// @return:
  ///
  transformToSQL() {
    log("=====transformToSQL=====");
    var list = map((item) => '\'$item\'').toList();
    return list.toString().replaceAll("[", "(").replaceAll("]", ")");
  }
}
