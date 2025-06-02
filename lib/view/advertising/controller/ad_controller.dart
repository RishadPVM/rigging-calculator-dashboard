import 'dart:developer';

import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/model/ad_plan_model.dart';

import '../../../model/ad_model.dart';


class AdController extends GetxController {
  ApiService apiService = ApiService();
  final RxBool isLoading = true.obs;
  var ads = <AdModel>[].obs;
  var plans = <AdsPlanModel>[].obs;

   var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
    
  }

   Future<void> loadData() async {
    isLoading.value = true;
    try {
      await Future.wait([
      fetchAds(),
      fetchAdPlans(),
    ]);
    } catch (e) {
      log("Error loading data: $e");
    } finally {
      isLoading.value = false;
    }
   
  }

  Future<void> fetchAds() async {
    try {
      final response = await apiService.get(ApiUrl.getAllAds);
      ads.assignAll(
        (response['ads'] as List)
            .map((json) => AdModel.fromJson(json))
            .toList(),
      );
    } catch (e) {
      log("Error fetching ads: $e");
    } 
  }

  Future<void> fetchAdPlans() async {
    try {
      final response = await apiService.get(ApiUrl.getAllAdPlans);
      if (response != null &&  response['success'] == true && response['plans'] != null) {
        final List<dynamic> plansData = response['plans'];
        plans.value = plansData
            .map((planJson) => AdsPlanModel.fromJson(planJson))
            .toList();
      }
    } catch (e) {
      log("Error fetching ad plans: $e");
    }
    }
  }

