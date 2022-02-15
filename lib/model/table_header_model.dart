class TableHeaderModel {
  String? title;
  String? dataIndex;

  TableHeaderModel({this.title, this.dataIndex});

  TableHeaderModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    dataIndex = json['dataIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['dataIndex'] = dataIndex;
    return data;
  }
}
