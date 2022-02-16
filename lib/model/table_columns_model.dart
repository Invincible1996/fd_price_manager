import 'package:flutter/cupertino.dart';

class TableColumnsModel {
  String? title;
  String? dataIndex;
  // define the item of the column, default is Text
  Widget Function(Map data)? builder;

  TableColumnsModel({this.title, this.dataIndex, this.builder});
}
