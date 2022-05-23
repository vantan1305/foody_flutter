import 'package:foody_flutter/data/api/api_client.dart';
import 'package:foody_flutter/data/controller/cart_controller.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/data/controller/recommended_product_controller.dart';
import 'package:foody_flutter/data/repository/cart_repo.dart';
import 'package:foody_flutter/data/repository/detail_food_repo.dart';
import 'package:foody_flutter/data/repository/recommendedFoodRepo.dart';
import 'package:foody_flutter/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> intit() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repository
  Get.lazyPut(() => DetailFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controller
  Get.lazyPut(() => DetailController(detailFoodRepo: Get.find()));
  Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
