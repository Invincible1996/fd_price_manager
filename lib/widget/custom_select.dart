///
/// @date: 2022/2/15 14:51
/// @author: kevin
/// @description: dart
///
import 'package:flutter/material.dart';

import 'select.dart';

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

  final String? defaultValue;

  const CustomSelect({
    Key? key,
    required this.title,
    required this.onItemSelected,
    required this.options,
    this.width = 80,
    this.selectType = SelectType.custom,
    this.onSearch,
    this.defaultValue,
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
          defaultValue: defaultValue,
        ),
      ],
    );
  }
}
