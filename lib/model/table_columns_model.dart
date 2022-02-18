import 'package:flutter/cupertino.dart';

class TableColumnsModel {
  String title;
  String dataIndex;

  String? tag;

  // define the item of the column, default is Text
  Widget Function(Map data)? builder;

  TableColumnsModel({
    required this.title,
    required this.dataIndex,
    this.tag,
    this.builder,
  });
}
