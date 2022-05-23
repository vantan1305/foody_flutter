import 'package:foody_flutter/data/repository/detail_food_repo.dart';
import 'package:foody_flutter/data/repository/recommendedFoodRepo.dart';
import 'package:foody_flutter/models/food_model.dart';
import 'package:get/get.dart';

class RecommendedFoodController extends GetxController {
  final RecommendedFoodRepo recommendedFoodRepo;

  RecommendedFoodController({required this.recommendedFoodRepo});

  List<ProductModel> _recommendedFoodRepoList = [];
  List<ProductModel> get recommendedFoodRepoList => _recommendedFoodRepoList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedFoodRepo() async {
    Response response = await recommendedFoodRepo.getRecommendedFoodRepo();
    if (response.statusCode == 200) {
      _recommendedFoodRepoList = [];
      _recommendedFoodRepoList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }
}
