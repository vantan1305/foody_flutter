import 'package:foody_flutter/models/food_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExit;
  String? time;
  ProductModel? productModel;

  CartModel(
      {this.id,
      this.img,
      this.name,
      this.price,
      this.quantity,
      this.isExit,
      this.time,
      this.productModel});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExit = json['isExit'];
    time = json['time'];
    productModel = ProductModel.fromJson(json['productModel']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'img': this.img,
      'quantity': this.quantity,
      'isExit': this.isExit,
      'time': this.time,
      'productModel': this.productModel!.toJson()
    };
  }
}
