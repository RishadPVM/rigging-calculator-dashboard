import 'dart:developer';

import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/model/feedback.dart';

import '../../../core/api/api_service.dart';
import '../../../core/api/api_url.dart';

class FeedbackController extends GetxController {

  ApiService apiService = ApiService();
  var feedbacks = <FeedbackModel>[].obs;

   Future<void> fetchAds() async {
    try {
      final response = await apiService.get(ApiUrl.getAllFeedbacks);
      feedbacks.assignAll(
        (response['feedbacks'] as List)
            .map((json) => FeedbackModel.fromJson(json))
            .toList(),
      );
    } catch (e) {
      log("Error fetching ads: $e");
    } 
  }
  
}