import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/model/admin_modal.dart';

class AdminController extends GetxController {
  
  // List to hold admin data
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
      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));
      admins.value = [
        AdminModel(adminName: "Admin 1", email: "admin1@example.com", createdAt: DateTime.now(), type: "superadmin", id: "1"),
        AdminModel(adminName: "Admin 2", email: "admin2@example.com", createdAt: DateTime.now(), type: "admin", id: "2"),
        AdminModel(adminName: "Admin 3", email: "admin3@example.com", createdAt: DateTime.now(), type: "admin", id: "3"),
      ];
      filteredAdmin.assignAll(admins);
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}