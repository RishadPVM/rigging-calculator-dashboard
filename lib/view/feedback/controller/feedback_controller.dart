import 'dart:developer';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/model/feedback.dart';
import '../../../core/api/api_service.dart';
import '../../../core/api/api_url.dart';

enum Status { loading, success, error, empty }

class FeedbackController extends GetxController {
  ApiService apiService = ApiService();
  var feedbacks = <FeedbackModel>[].obs;
  var status = Status.loading.obs;
  var errorMessage = ''.obs;

  Future<void> fetchAds() async {
    try {
      status.value = Status.loading;
      errorMessage.value = '';
      
      final response = await apiService.get(ApiUrl.getAllFeedbacks);
      
      if (response['feedbacks'] == null || response['feedbacks'].isEmpty) {
        status.value = Status.empty;
        feedbacks.clear();
        return;
      }

      final feedbackList = (response['feedbacks'] as List)
          .map((json) => FeedbackModel.fromJson(json))
          .toList();
      
      feedbacks.assignAll(feedbackList);
      status.value = Status.success;
    } catch (e) {
      errorMessage.value = e.toString();
      log("Error fetching feedback: $e");
      status.value = Status.error;
      feedbacks.clear();
    }
  }
}