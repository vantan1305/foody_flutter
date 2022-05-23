import 'package:flutter/services.dart';
import 'package:foody_flutter/data/api/api_client.dart';
import 'package:foody_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedFoodRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedFoodRepo({required this.apiClient});
  Future<Response> getRecommendedFoodRepo() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
