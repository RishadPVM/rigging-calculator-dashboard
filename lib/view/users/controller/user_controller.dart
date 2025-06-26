import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/core/country_decode.dart';

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
    final String aiUserID = dotenv.env['AI_USERID'] ?? '';
    users.removeWhere((user) => user.id == aiUserID);

    // Sort users by lastActive (descending: most recent first)
    users.sort((a, b) {
      final aLastActive = (a.lastActiveAt ?? '').toString();
      final bLastActive = (b.lastActiveAt ?? '').toString();
      return bLastActive.compareTo(aLastActive);
    });

    filteredUsers.assignAll(users);
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
          final countryKey = user.country;
          final country = countryMap[countryKey] != null
              ? countryMap[countryKey]!.toLowerCase()
              : '';
              final dateFormatter = DateFormat('dd-MM-yyyy');
              final createdDate = dateFormatter.format(user.createdAt);
          return companyName.contains(searchQuery.value) ||
              email.contains(searchQuery.value) ||
              country.contains(searchQuery.value) ||
              createdDate.contains(searchQuery.value);
        }).toList(),
      );
    }
  }
}
