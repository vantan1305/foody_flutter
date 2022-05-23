import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foody_flutter/data/controller/cart_controller.dart';
import 'package:foody_flutter/data/repository/detail_food_repo.dart';
import 'package:foody_flutter/models/cart_model.dart';
import 'package:foody_flutter/models/food_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final DetailFoodRepo detailFoodRepo;
  int _quantity = 0;
  int get quantity => _quantity;
  int _totalItem = 0;
  int get totalItem => _totalItem + _quantity;

  DetailController({required this.detailFoodRepo});

  List<ProductModel> _detailFoodRepoList = [];
  List<ProductModel> get detailFoodList => _detailFoodRepoList;
  late CartController _cartController;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getDetailFoodList() async {
    Response response = await detailFoodRepo.getDetailFoodList();
    if (response.statusCode == 200) {
      _detailFoodRepoList = [];
      _detailFoodRepoList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (totalItem < 0) {
      Get.snackbar('Item Count', 'You Can' 't remove more ',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      if (_totalItem > 0) {
        _quantity = _totalItem;
        return _quantity;
      }
      return 0;
    } else if (totalItem > 10) {
      Get.snackbar('Item Count', 'You Can' 't add more ',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return 10;
    } else {
      return quantity;
    }
  }

  void initFoodPrice(ProductModel productModel, CartController cartController) {
    _quantity = 0;
    _totalItem = 0;
    _cartController = cartController;
    var exit = false;
    exit = _cartController.exitInCart(productModel);
    if (exit) {
      _totalItem = _cartController.getQuantity(productModel);
    }
  }

  void addItemToCart(ProductModel productModel) {
    _cartController.addItemToCart(productModel, _quantity);
    _quantity = 0;
    _totalItem = _cartController.getQuantity(productModel);
    _cartController.items.forEach((key, value) {});
    update();
  }

  int get totalItemsInCart {
    return _cartController.totalItemController;
  }

  List<CartModel> get getItemInCart {
    return _cartController.getItemsInCart;
  }
}
