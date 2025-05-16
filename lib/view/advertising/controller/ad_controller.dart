import 'dart:developer';

import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';

import '../../../model/ad_model.dart';


class AdController extends GetxController {
  ApiService apiService = ApiService();
  final RxBool isLoading = true.obs;
  var ads = <AdModel>[].obs;

  @override
  void onInit() {
    fetchAds();
    super.onInit();
    
  }

  Future<void> fetchAds() async {
    final response = await apiService.get(ApiUrl.getAllAds);
    ads.assignAll(
      (response['ads'] as List)
          .map((json) => AdModel.fromJson(json))
          .toList(),
    );
    log(ads.length.toString());
    isLoading.value = false;
  }
}
