import 'dart:developer';

import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/utils/country_decode.dart';

import '../../../model/user_model.dart';

class UserController extends GetxController {
  ApiService apiService = ApiService();
  final RxBool isLoading = true.obs;
  var users = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    filteredUsers.assignAll(users);
  }

  Future<void> fetchUsers() async {
    final response = await apiService.get(ApiUrl.getAllUser);
    users.assignAll(
      (response['Allusers'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList(),
    );
    filteredUsers.assignAll(users);
    log('Users fetched: ${users.length}');
    isLoading.value = false;
  }

  // Search users by name, email, or country
  void searchUsers(String query) {
    searchQuery.value = query.toLowerCase();
    if (query.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      filteredUsers.assignAll(
        users.where((user) {
          final companyName = user.companyName?.toLowerCase() ?? '';
          final email = user.email.toLowerCase();
          final country = countryMap[user.country]!.toLowerCase();
          return companyName.contains(searchQuery.value) ||
              email.contains(searchQuery.value) ||
              country.contains(searchQuery.value);
        }).toList(),
      );
    }
    log('Filtered users: ${filteredUsers.length}');
  }
}
