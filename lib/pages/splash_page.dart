import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/data/controller/recommended_product_controller.dart';
import 'package:foody_flutter/routers/router_helper.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> _loadResoure() async {
    await Get.find<DetailController>().getDetailFoodList();
    await Get.find<RecommendedFoodController>().getRecommendedFoodRepo();
  }

  @override
  void initState() {
    super.initState();
    _loadResoure();
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..forward();
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.linear);
    Timer(Duration(seconds: 5), () => Get.offNamed(RouterHelper.getInitical()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'images/logo3.jpg',
                width: Dimission.withLogo250,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'images/logo2.jpg',
              width: Dimission.withLogo250,
            ),
          )
        ],
      ),
    );
  }
}
