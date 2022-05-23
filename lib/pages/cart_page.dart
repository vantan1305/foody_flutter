import 'package:flutter/material.dart';
import 'package:foody_flutter/base/no_data_page.dart';
import 'package:foody_flutter/data/controller/cart_controller.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/data/controller/recommended_product_controller.dart';
import 'package:foody_flutter/home/main_page.dart';
import 'package:foody_flutter/pages/foody_detail.dart';
import 'package:foody_flutter/routers/router_helper.dart';
import 'package:foody_flutter/utils/app_constants.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:foody_flutter/utils/icon_app.dart';
import 'package:foody_flutter/widget/big_text.dart';
import 'package:foody_flutter/widget/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: Dimission.height20,
            right: Dimission.height20,
            top: Dimission.height20 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterHelper.getInitical());
                  },
                  child: IconApp(
                    iconData: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    bigSize: Dimission.iconSize24,
                    backgroundColor: Color.fromARGB(255, 13, 160, 153),
                  ),
                ),
                SizedBox(
                  width: Dimission.height20 * 4,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterHelper.getInitical());
                  },
                  child: IconApp(
                    iconData: Icons.home_outlined,
                    iconColor: Colors.white,
                    bigSize: Dimission.iconSize24,
                    backgroundColor: Color.fromARGB(255, 13, 158, 151),
                  ),
                ),
                IconApp(
                  iconData: Icons.shopping_cart,
                  iconColor: Colors.white,
                  bigSize: Dimission.iconSize24,
                  backgroundColor: Color.fromARGB(255, 10, 158, 151),
                ),
              ],
            )),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getItemsInCart.length > 0
              ? Positioned(
                  top: Dimission.height20 * 5,
                  left: Dimission.height20,
                  right: Dimission.height20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimission.height10),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (controller) {
                        var _cartList = controller.getItemsInCart;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimission.height20 * 5,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var detailFoodIndex =
                                            Get.find<DetailController>()
                                                .detailFoodList
                                                .indexOf(_cartList[index]
                                                    .productModel!);
                                        if (detailFoodIndex >= 0) {
                                          Get.toNamed(
                                              RouterHelper.getFoodDetail(
                                                  detailFoodIndex, 'cartPage'));
                                        } else {
                                          var recommendedFoodIndex = Get.find<
                                                  RecommendedFoodController>()
                                              .recommendedFoodRepoList
                                              .indexOf(_cartList[index]
                                                  .productModel!);
                                          if (recommendedFoodIndex < 0) {
                                            Get.snackbar('History product',
                                                'Product review is not availble for history products',
                                                backgroundColor:
                                                    Colors.redAccent,
                                                colorText: Color.fromARGB(
                                                    255, 110, 250, 227));
                                          } else {
                                            Get.toNamed(
                                                RouterHelper.getRecommendedFood(
                                                    recommendedFoodIndex,
                                                    'cartPage'));
                                          }
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            0, 0, 0, Dimission.height10),
                                        height: Dimission.height20 * 5,
                                        width: Dimission.height20 * 5,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimission.height20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(AppConstants
                                                      .BASE_URL +
                                                  AppConstants.UPLOAD_IMG_URL +
                                                  controller
                                                      .getItemsInCart[index]
                                                      .img!),
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimission.height10,
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: Dimission.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: controller
                                                .getItemsInCart[index].name!,
                                            color: Colors.black87,
                                          ),
                                          SmallText(
                                              text:
                                                  'controller.getItemsInCart[index]'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    '\$ ${controller.getItemsInCart[index].price.toString()}',
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    Dimission.height10,
                                                    Dimission.height10,
                                                    Dimission.height10,
                                                    Dimission.height10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimission.height20),
                                                    color: Colors.white),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItemToCart(
                                                            _cartList[index]
                                                                .productModel!,
                                                            -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          Dimission.height10 /
                                                              2,
                                                    ),
                                                    BigText(
                                                        text: _cartList[index]
                                                            .quantity
                                                            .toString()),
                                                    SizedBox(
                                                      width:
                                                          Dimission.height10 /
                                                              2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.addItemToCart(
                                                            _cartList[index]
                                                                .productModel!,
                                                            1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      }),
                    ),
                  ))
              : NoDataPage(text: 'Your Cart Is Emtry');
        })
      ]),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return Container(
          height: Dimission.bottonNav,
          padding: EdgeInsets.fromLTRB(Dimission.height20, Dimission.height20,
              Dimission.height20, Dimission.height20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimission.height20),
                  topRight: Radius.circular(Dimission.height20)),
              color: Color.fromARGB(255, 248, 248, 238)),
          child: controller.getItemsInCart.length > 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          Dimission.height20,
                          Dimission.height20,
                          Dimission.height20,
                          Dimission.height20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimission.height20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Dimission.height10,
                          ),
                          BigText(
                            text: '\$ ' + controller.totalAmount.toString(),
                            color: Colors.redAccent,
                          ),
                          SizedBox(
                            width: Dimission.height10,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            Dimission.height20,
                            Dimission.height20,
                            Dimission.height20,
                            Dimission.height20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimission.height20),
                            color: Color.fromARGB(255, 9, 150, 103)),
                        child: GestureDetector(
                          onTap: () {
                            controller.addCartToHistory();
                            // Get.toNamed(RouterHelper.getCartHistory());
                          },
                          child: BigText(
                            text: 'Check Out',
                            color: Colors.white,
                          ),
                        ))
                  ],
                )
              : Container(),
        );
      }),
    );
  }
}
