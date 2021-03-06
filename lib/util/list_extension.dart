///
/// @date: 2022/2/17 17:44
/// @author: kevin
/// @description: dart
///
///
extension ListExtension on List {
  ///
  /// @description: List转换 sql String
  /// @param {type}
  /// @return:
  ///
  transformToSQL() {
    var list = map((item) => '\'$item\'').toList();
    return list.toString().replaceAll("[", "(").replaceAll("]", ")");
  }
}
