import 'package:flutter/services.dart';
import 'package:foody_flutter/data/api/api_client.dart';
import 'package:foody_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class DetailFoodRepo extends GetxService {
  final ApiClient apiClient;

  DetailFoodRepo({required this.apiClient});
  Future<Response> getDetailFoodList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
