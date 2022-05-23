// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:foody_flutter/data/controller/cart_controller.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/home/main_page.dart';
import 'package:foody_flutter/pages/cart_page.dart';
import 'package:foody_flutter/routers/router_helper.dart';
import 'package:foody_flutter/utils/app_constants.dart';
import 'package:foody_flutter/utils/colum_app.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:foody_flutter/utils/icon_app.dart';
import 'package:foody_flutter/widget/big_text.dart';
import 'package:foody_flutter/widget/show_text_widget.dart';
import 'package:get/get.dart';

class FoodyDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const FoodyDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<DetailController>().detailFoodList[pageId];
    Get.find<DetailController>()
        .initFoodPrice(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: Dimission.height45 - 100.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.maxFinite,
              height: Dimission.foodyDetailSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(AppConstants.BASE_URL +
                    AppConstants.UPLOAD_IMG_URL +
                    product.img!),
              )),
            ),
          ),
          Positioned(
            height: Dimission.height45 + 60.0,
            left: Dimission.height20,
            right: Dimission.height20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == 'cartPage') {
                        Get.toNamed(RouterHelper.getCartList());
                      } else if (page == 'initical') {
                        Get.toNamed(RouterHelper.getInitical());
                      }
                    },
                    child: IconApp(iconData: Icons.arrow_back_ios)),
                GetBuilder<DetailController>(builder: (controller) {
                  return Stack(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouterHelper.getCartList());
                          },
                          child: IconApp(iconData: Icons.shopping_cart)),
                      Get.find<DetailController>().totalItemsInCart >= 0
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: IconApp(
                                iconData: Icons.circle,
                                size: 22.0,
                                iconColor: Colors.transparent,
                                backgroundColor:
                                    Color.fromARGB(255, 18, 177, 150),
                              ),
                            )
                          : Container(),
                      Get.find<DetailController>().totalItemsInCart >= 0
                          ? Positioned(
                              right: 3.0,
                              top: 2.0,
                              child: BigText(
                                text: controller.totalItemsInCart.toString(),
                                size: 16.0,
                                color: Colors.white,
                              ))
                          : Container()
                    ],
                  );
                })
              ],
            ),
          ),
          Positioned(
              top: Dimission.foodyDetailSize - 100.0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  padding: EdgeInsets.fromLTRB(Dimission.height20,
                      Dimission.height20, Dimission.height20, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimission.height20),
                          topRight: Radius.circular(Dimission.height20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColumApp(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimission.height20,
                      ),
                      BigText(text: 'Introdue'),
                      SizedBox(
                        height: Dimission.height20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ShowTextWidget(text: product.description!),
                        ),
                      )
                    ],
                  )))
        ],
      ),
      bottomNavigationBar:
          GetBuilder<DetailController>(builder: (foodDetailPrice) {
        return Container(
          height: Dimission.bottonNav,
          padding: EdgeInsets.fromLTRB(Dimission.height20, Dimission.height20,
              Dimission.height20, Dimission.height20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimission.height20),
                  topRight: Radius.circular(Dimission.height20)),
              color: Color.fromARGB(255, 206, 204, 200)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(Dimission.height20,
                    Dimission.height20, Dimission.height20, Dimission.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimission.height20),
                    color: Colors.white),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        foodDetailPrice.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: Dimission.height10,
                    ),
                    BigText(text: foodDetailPrice.totalItem.toString()),
                    SizedBox(
                      width: Dimission.height10,
                    ),
                    GestureDetector(
                      onTap: () {
                        foodDetailPrice.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(Dimission.height20,
                    Dimission.height20, Dimission.height20, Dimission.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimission.height20),
                    color: Color.fromARGB(255, 9, 150, 103)),
                child: GestureDetector(
                  onTap: () {
                    foodDetailPrice.addItemToCart(product);
                  },
                  child: BigText(
                    text: '\$ ${product.price!} | Add to Cart',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
