///
/// @date: 2022/2/15 14:51
/// @author: kevin
/// @description: dart
///
import 'package:fd_price_manager/widget/select.dart';
import 'package:flutter/material.dart';

class CustomSelect<T> extends StatelessWidget {
  // 标题
  final String title;

  //
  final Function(String) onItemSelected;
  final Function(String)? onSearch;

  // 选项
  final List<T> options;

  // 宽度
  final double width;

  final SelectType selectType;

  const CustomSelect({
    Key? key,
    required this.title,
    required this.onItemSelected,
    required this.options,
    this.width = 80,
    this.selectType = SelectType.custom,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title: '),
        const SizedBox(width: 10),
        Select<T>(
          type: selectType,
          width: width,
          options: options,
          onItemSelected: onItemSelected,
          onSearch: onSearch,
        ),
      ],
    );
  }
}
