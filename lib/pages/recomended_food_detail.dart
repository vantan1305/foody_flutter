import 'package:flutter/material.dart';
import 'package:foody_flutter/data/controller/cart_controller.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/data/controller/recommended_product_controller.dart';
import 'package:foody_flutter/pages/cart_page.dart';
import 'package:foody_flutter/routers/router_helper.dart';
import 'package:foody_flutter/utils/app_constants.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:foody_flutter/utils/icon_app.dart';
import 'package:foody_flutter/widget/big_text.dart';
import 'package:foody_flutter/widget/show_text_widget.dart';
import 'package:get/get.dart';

class RecomendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecomendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedFoodController>().recommendedFoodRepoList[pageId];
    Get.find<DetailController>()
        .initFoodPrice(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<RecommendedFoodController>(
            builder: (recommendedProduct) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: Dimission.toolBarHeight70,
                title: Row(
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
                        child: IconApp(iconData: Icons.clear)),
                    GetBuilder<DetailController>(builder: (controller) {
                      return Stack(
                        children: [
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
                                        Color.fromARGB(255, 10, 150, 150),
                                  ))
                              : Container(),
                          Get.find<DetailController>().totalItemsInCart >= 0
                              ? Positioned(
                                  right: 3.0,
                                  top: 2.0,
                                  child: BigText(
                                    text:
                                        controller.totalItemsInCart.toString(),
                                    color: Colors.white,
                                    size: 16.0,
                                  ))
                              : Container()
                        ],
                      );
                    })
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20.0),
                  child: Container(
                    child: Center(
                      child: BigText(
                        text: product.name!,
                        size: Dimission.height26,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 5.0, 0, 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimission.height20),
                            topRight: Radius.circular(Dimission.height20)),
                        color: Colors.white),
                  ),
                ),
                pinned: true,
                backgroundColor: Color.fromARGB(255, 255, 205, 111),
                expandedHeight: Dimission.expandHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_IMG_URL +
                        product.img!,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        Dimission.height20, 0, Dimission.height20, 0),
                    child: ShowTextWidget(text: product.description!),
                  ),
                ],
              )),
            ],
          );
        }),
        bottomNavigationBar:
            GetBuilder<DetailController>(builder: (foodDetailPrice) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    Dimission.height20 * 2.5,
                    Dimission.height10,
                    Dimission.height20 * 2.5,
                    Dimission.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        foodDetailPrice.setQuantity(false);
                      },
                      child: IconApp(
                        bigSize: Dimission.iconSize24,
                        iconData: Icons.remove,
                        backgroundColor: Color.fromARGB(255, 11, 189, 150),
                        iconColor: Colors.white,
                      ),
                    ),
                    BigText(
                      text: '\$' +
                          product.price.toString() +
                          ' X ' +
                          '${foodDetailPrice.totalItem}',
                      size: Dimission.height26,
                    ),
                    GestureDetector(
                      onTap: () {
                        foodDetailPrice.setQuantity(true);
                      },
                      child: IconApp(
                        bigSize: Dimission.iconSize24,
                        iconData: Icons.add,
                        backgroundColor: Color.fromARGB(255, 13, 187, 149),
                        iconColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: Dimission.bottonNav,
                padding: EdgeInsets.fromLTRB(Dimission.height20,
                    Dimission.height20, Dimission.height20, Dimission.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimission.height20),
                        topRight: Radius.circular(Dimission.height20)),
                    color: Color.fromARGB(255, 206, 204, 200)),
                child: Row(
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
                      child: Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 11, 170, 149),
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
                            color: Color.fromARGB(255, 16, 179, 151)),
                        child: GestureDetector(
                          onTap: () {
                            foodDetailPrice.addItemToCart(product);
                          },
                          child: BigText(
                            text: '\$' +
                                product.price.toString() +
                                '| Add to Cart',
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
