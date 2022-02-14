///
/// @date: 2022/2/14 14:53
/// @author: kevin
/// @description: dart
///
class ProductModel {
  int? id;
  String? name;
  String? color;
  double? price;
  String? description;
  String? createTime;
  String? updateTime;

  ProductModel({this.id, this.name, this.color, this.price, this.description, this.createTime, this.updateTime});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    price = json['price'];
    description = json['description'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['price'] = this.price;
    data['description'] = this.description;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    return data;
  }
}
