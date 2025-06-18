import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/model/dashboard_data_model.dart';
import 'package:leo_rigging_dashboard/view/Errors/server_error.dart';
import 'package:leo_rigging_dashboard/view/nav/controller/navcontroller.dart';
import 'package:leo_rigging_dashboard/view/nav/nav.dart';

import '../../../core/api/api_service.dart';
import '../../../core/api/api_url.dart';

class DasboardController extends GetxController {
  ApiService apiService = ApiService();
  final RxBool isLoading = false.obs;
  var dashboardData = DashBoardDataModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

   final Navcontroller controller = Get.put(Navcontroller());

  Future<void> fetchDashboardData() async {
   try {
      isLoading.value = true;
      final response = await apiService.get(ApiUrl.getDashboardData);
      if (response != null) {
        dashboardData.value = DashBoardDataModel.fromJson(response);
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      controller.selectedBody.value = InternalServerErrorPage(onPressed: () => Get.to(() => NavPage()));
    } finally {
      isLoading.value = false;
    }
  }
}
