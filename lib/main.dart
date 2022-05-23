import 'package:flutter/material.dart';
import 'package:foody_flutter/data/controller/cart_controller.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/data/controller/recommended_product_controller.dart';
import 'package:foody_flutter/home/main_page.dart';
import 'package:foody_flutter/pages/foody_detail.dart';
import 'package:foody_flutter/routers/router_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.intit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<DetailController>(builder: (_) {
      return GetBuilder<RecommendedFoodController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: MainPage(),
          initialRoute: RouterHelper.getSplashPage(),
          getPages: RouterHelper.routes,
        );
      });
    });
  }
}
