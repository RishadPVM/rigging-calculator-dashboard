import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/model/ad_plan_model.dart';

import '../../../model/ad_model.dart';


class AdController extends GetxController {
  ApiService apiService = ApiService();
  final RxBool isLoading = false.obs;
  final RxBool isCreateUpdating = false.obs;
  var ads = <AdModel>[].obs;
  var plans = <AdsPlanModel>[].obs;

   // text controller 
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController planBadgeController = TextEditingController();
  final TextEditingController planMinViewController = TextEditingController();
  final TextEditingController planMaxViewController = TextEditingController(); 
  final TextEditingController planDescriptionController = TextEditingController();
  final TextEditingController planPriceController = TextEditingController();
  final TextEditingController planOfferPriceController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


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

 Future<void> createAdPlan() async {
  
  if (!formKey.currentState!.validate()) {
    Get.snackbar("Error", "Please fill all fields correctly");
    return;
  }
  if (planNameController.text.isEmpty ||
      planMinViewController.text.isEmpty ||
      planMaxViewController.text.isEmpty ||
      planPriceController.text.isEmpty ||
      planOfferPriceController.text.isEmpty) {
    Get.snackbar("Error", "Please fill all fields");
    return;
  }
  if (int.parse(planMinViewController.text) > int.parse(planMaxViewController.text)) {
    Get.snackbar("Error", "Minimum views cannot be greater than maximum views");
    return;
  }

  isCreateUpdating.value = true;

  try {
    final response = await apiService.post(ApiUrl.createAdPlan, body: {
      'title': planNameController.text,
      'badge': planBadgeController.text,
      'minViews': int.parse(planMinViewController.text),
      'maxViews': int.parse(planMaxViewController.text),
      'originalPrice': planPriceController.text,
      'offerPrice': planOfferPriceController.text,
      'description': planDescriptionController.text,
      "isActive": true
    });

    if (response != null && response['success'] == true) {
      Get.snackbar("Success", "Ad Plan created successfully");
      await fetchAdPlans();
    } else {
      Get.snackbar("Error", "Failed to create Ad Plan: ${response.toString()}");
    }
  } catch (e) {
    log("Error creating ad plan: $e");
    Get.snackbar("Error", "Failed to create Ad Plan: ${e.toString()}");
  } finally {
    isCreateUpdating.value = false;
  }
}

  Future<void> updateAdPlan({required String planId}) async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  if (planNameController.text.isEmpty ||
      planMinViewController.text.isEmpty ||
      planMaxViewController.text.isEmpty ||
      planPriceController.text.isEmpty ||
      planOfferPriceController.text.isEmpty) {
    Get.snackbar("Error", "Please fill all fields");
    return;
  }

  if (int.parse(planMinViewController.text) > int.parse(planMaxViewController.text)) {
    Get.snackbar("Error", "Minimum views cannot be greater than maximum views");
    return;
  }

  if (double.tryParse(planPriceController.text) == null ||
      double.tryParse(planOfferPriceController.text) == null) {
    Get.snackbar("Error", "Invalid price format");
    return;
  }

  isCreateUpdating.value = true;

  try {
    final url = '${ApiUrl.editAdPlan}$planId';
    log("Updating Ad Plan at URL: $url");

    final response = await apiService.put(url, body: {
      'title': planNameController.text.trim(),
      'badge': planBadgeController.text.trim(),
      'minViews': int.parse(planMinViewController.text),
      'maxViews': int.parse(planMaxViewController.text),
      'description': planDescriptionController.text.trim(),
      'originalPrice': planPriceController.text.trim(),
      'offerPrice': planOfferPriceController.text.trim(),
    });

    if (response != null && response['success'] == true) {
      Get.snackbar("Success", "Ad Plan updated successfully");
      await fetchAdPlans();
    } else {
      Get.snackbar("Error", "Failed to update Ad Plan: ${response.toString()}");
    }
  } catch (e) {
    log("Error updating ad plan: $e");
    Get.snackbar("Error", "Failed to update Ad Plan: ${e.toString()}");
  } finally {
    isCreateUpdating.value = false;
  }
}

}