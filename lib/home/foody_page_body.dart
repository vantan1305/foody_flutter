// ignore_for_file: prefer_final_fields

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/data/controller/recommended_product_controller.dart';
import 'package:foody_flutter/models/food_model.dart';
import 'package:foody_flutter/pages/foody_detail.dart';
import 'package:foody_flutter/routers/router_helper.dart';
import 'package:foody_flutter/utils/app_constants.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:foody_flutter/widget/big_text.dart';
import 'package:foody_flutter/widget/small_text.dart';
import 'package:foody_flutter/widget/status_foody.dart';
import 'package:get/get.dart';

class FoodyPageBody extends StatefulWidget {
  // int pageId;
  const FoodyPageBody({Key? key}) : super(key: key);

  @override
  _FoodyPageBodyState createState() => _FoodyPageBodyState();
}

class _FoodyPageBodyState extends State<FoodyPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currPage = 0.0;
  double scaleFactor = 0.8;
  double _height = Dimission.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<DetailController>(builder: (detailProducts) {
          return detailProducts.isLoaded
              ? Container(
                  height: Dimission.pageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: detailProducts.detailFoodList.length,
                    itemBuilder: (context, position) {
                      return _buildItemPage(
                          position, detailProducts.detailFoodList[position]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: Color.fromARGB(255, 10, 163, 150),
                );
        }),
        GetBuilder<DetailController>(builder: (detailProducts) {
          return DotsIndicator(
            dotsCount: detailProducts.detailFoodList.isEmpty
                ? 1
                : detailProducts.detailFoodList.length,
            position: currPage,
            decorator: DotsDecorator(
              activeColor: Color.fromARGB(255, 13, 165, 152),
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimission.height30,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(Dimission.height20, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended', color: Colors.black),
              SizedBox(
                width: Dimission.height10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 3.0),
                child: BigText(
                  text: '.',
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                width: Dimission.height10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 1.0),
                child: SmallText(text: 'Food paring'),
              ),
            ],
          ),
        ),
        GetBuilder<RecommendedFoodController>(builder: (recommendedFood) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedFood.recommendedFoodRepoList.isEmpty
                  ? 1
                  : recommendedFood.recommendedFoodRepoList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                        RouterHelper.getRecommendedFood(index, 'initical'));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimission.height20,
                        right: Dimission.height20,
                        bottom: Dimission.height10),
                    child: Row(
                      children: [
                        Container(
                          height: Dimission.listViewSize,
                          width: Dimission.listViewSize,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimission.height20),
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(AppConstants.BASE_URL +
                                    AppConstants.UPLOAD_IMG_URL +
                                    recommendedFood
                                        .recommendedFoodRepoList[index].img!),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimission.listViewTextSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimission.height20),
                                  bottomRight:
                                      Radius.circular(Dimission.height20),
                                ),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimission.height20,
                                  top: Dimission.height10,
                                  right: Dimission.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                      text: recommendedFood
                                          .recommendedFoodRepoList[index]
                                          .name!),
                                  SizedBox(
                                    height: Dimission.height10,
                                  ),
                                  SmallText(text: 'Thực phẩm tươi sạch'),
                                  SizedBox(
                                    height: Dimission.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StatusFoody(
                                          icon: Icons.circle_sharp,
                                          text: 'Normal',
                                          color: Color(0xFFccc7c5),
                                          iconColor: Colors.yellow),
                                      StatusFoody(
                                          icon: Icons.location_on,
                                          text: '1 km',
                                          color: Color(0xFFccc7c5),
                                          iconColor:
                                              Color.fromARGB(255, 8, 163, 150)),
                                      StatusFoody(
                                          icon: Icons.access_time_rounded,
                                          text: '32 min',
                                          color: Color(0xFFccc7c5),
                                          iconColor: Colors.red),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }),
      ],
    );
  }

  Widget _buildItemPage(int index, ProductModel detailFood) {
    Matrix4 matrix4 = new Matrix4.identity();
    if (index == currPage.floor()) {
      var currSale = 1 - (currPage - index) * (1 - scaleFactor);
      var currStrans = _height * (1 - currSale) / 2;
      matrix4 = Matrix4.diagonal3Values(1.0, currSale, 1.0)
        ..setTranslationRaw(0, currStrans, 0);
    } else if (index == (currPage.floor() + 1)) {
      var currSale = scaleFactor + (currPage - index + 1) * (1 - scaleFactor);
      var currStrans = _height * (1 - currSale) / 2;
      matrix4 = Matrix4.diagonal3Values(1.0, currSale, 1.0);
      matrix4 = Matrix4.diagonal3Values(1.0, currSale, 1.0)
        ..setTranslationRaw(0, currStrans, 0);
    } else if (index == (currPage.floor() - 1)) {
      var currSale = 1 - (currPage - index) * (1 - scaleFactor);
      var currStrans = _height * (1 - currSale) / 2;
      matrix4 = Matrix4.diagonal3Values(1.0, currSale, 1.0);
      matrix4 = Matrix4.diagonal3Values(1.0, currSale, 1.0)
        ..setTranslationRaw(0, currStrans, 0);
    } else {
      var currSale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1.0, currSale, 1.0)
        ..setTranslationRaw(0, _height * (1 - scaleFactor) / 2, 1.0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouterHelper.getFoodDetail(index, 'initical'));
            },
            child: Container(
              height: Dimission.pageViewContainer,
              margin: EdgeInsets.fromLTRB(
                  Dimission.height10, 0, Dimission.height10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimission.height30),
                  color: index.isEven
                      ? Color.fromARGB(255, 6, 150, 150)
                      : Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_IMG_URL +
                          detailFood.img!),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimission.pageViewTextContainer,
              margin: EdgeInsets.fromLTRB(Dimission.height40, 0,
                  Dimission.height40, Dimission.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimission.height20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(96, 156, 156, 156),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.fromLTRB(Dimission.height15,
                    Dimission.height15, Dimission.height15, Dimission.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: detailFood.name!),
                    SizedBox(
                      height: Dimission.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    size: 15.0,
                                    color: Color.fromARGB(255, 8, 161, 149),
                                  )),
                        ),
                        SmallText(text: '4.5'),
                        SmallText(text: '1234 comments'),
                      ],
                    ),
                    SizedBox(
                      height: Dimission.height15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusFoody(
                            icon: Icons.circle_sharp,
                            text: 'Normal',
                            color: Color(0xFFccc7c5),
                            iconColor: Colors.yellow),
                        StatusFoody(
                            icon: Icons.location_on,
                            text: '1 km',
                            color: Color(0xFFccc7c5),
                            iconColor: Color.fromARGB(255, 6, 163, 150)),
                        StatusFoody(
                            icon: Icons.access_time_rounded,
                            text: '32 min',
                            color: Color(0xFFccc7c5),
                            iconColor: Colors.red),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
