import 'package:flutter/material.dart';
import 'package:foody_flutter/data/repository/cart_repo.dart';
import 'package:foody_flutter/models/cart_model.dart';
import 'package:foody_flutter/models/food_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  List<CartModel> storageCartItems = [];

  void addItemToCart(ProductModel productModel, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            time: DateTime.now().toString(),
            img: value.img,
            isExit: true,
            quantity: value.quantity! + quantity,
            productModel: productModel);
      });
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
            productModel.id!,
            () => CartModel(
                id: productModel.id,
                name: productModel.name,
                price: productModel.price,
                time: DateTime.now().toString(),
                img: productModel.img,
                isExit: true,
                quantity: quantity,
                productModel: productModel));
      } else {
        Get.snackbar(
            'Item Count', 'You Should at least add a item in the cart ',
            backgroundColor: Colors.redAccent,
            colorText: Color.fromARGB(255, 110, 250, 227));
      }
    }

    cartRepo.addCartList(getItemsInCart);
    update();
  }

  bool exitInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel productModel) {
    var quantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItemController {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItemsInCart {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageCartItems;
  }

  set setCart(List<CartModel> items) {
    storageCartItems = items;

    for (int i = 0; i < storageCartItems.length; i++) {
      _items.putIfAbsent(
          storageCartItems[i].productModel!.id!, () => storageCartItems[i]);
    }
  }

  void addCartToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getListCartHistory();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addCartList(getItemsInCart);
    update();
  }
}
