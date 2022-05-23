import 'package:foody_flutter/home/home_page.dart';
import 'package:foody_flutter/home/main_page.dart';
import 'package:foody_flutter/pages/cart_history.dart';
import 'package:foody_flutter/pages/cart_page.dart';
import 'package:foody_flutter/pages/foody_detail.dart';
import 'package:foody_flutter/pages/recomended_food_detail.dart';
import 'package:foody_flutter/pages/splash_page.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String initical = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String splashPage = '/splash-page';
  static const String cartHistory = '/cart-history';

  static String getSplashPage() => '$splashPage';
  static String getFoodDetail(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getInitical() => '$initical';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartList() => '${cartPage}';
  static String getCartHistory() => '${cartHistory}';

  static List<GetPage> routes = [
    GetPage(
        name: splashPage,
        page: () {
          return SplashPage();
        }),
    GetPage(
        name: initical,
        page: () {
          return HomePage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return FoodyDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecomendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartHistory,
        page: () {
          return CartHistory();
        },
        transition: Transition.fadeIn)
  ];
}
