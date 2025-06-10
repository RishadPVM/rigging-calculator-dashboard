import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/model/admin_modal.dart';

class AdminController extends GetxController {
  ApiService apiService = ApiService();
  var admins = <AdminModel>[].obs;
  var filteredAdmin = <AdminModel>[].obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit(); 
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    isLoading.value = true;
    try {
      final response = await apiService.get(ApiUrl.getAllAdmins);
      filteredAdmin.assignAll(
        (response['admins'] as List)
            .map((json) => AdminModel.fromJson(json))
            .toList(),
      );
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
