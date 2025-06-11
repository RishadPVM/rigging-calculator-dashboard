import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/model/admin_modal.dart';

class AdminController extends GetxController {
  final ApiService apiService = ApiService();
  var admins = <AdminModel>[].obs;
  var filteredAdmin = <AdminModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    isLoading.value = true;
    try {
      final response = await apiService.get(ApiUrl.getAllAdmins);
      if (response != null && response['success'] == true) {
        final List<dynamic> adminsJson = response['admins'] ?? [];
        filteredAdmin.assignAll(
          adminsJson.map((json) => AdminModel.fromJson(json)).toList(),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Failed to fetch admin data: $e');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAdminRoles(String adminId, Roles roles) async {
    isLoading.value = true;
    try {
      final response = await apiService.put(
        "${ApiUrl.updateAdmin}$adminId",
        body: {"roles": roles.toJson()},
        headers: {"Content-Type": "application/json"},
      );

      log('Raw Response: $response');

      final parsed = response is String ? jsonDecode(response) : response;

      if (parsed['success'] == true) {
        final index = filteredAdmin.indexWhere((a) => a.id == adminId);
        if (index != -1) {
          final old = filteredAdmin[index];
          filteredAdmin[index] = AdminModel(
            id: old.id,
            email: old.email,
            adminName: old.adminName,
            profilePhoto: old.profilePhoto,
            createdAt: old.createdAt,
            lastActiveAt: old.lastActiveAt,
            isBlocked: old.isBlocked,
            type: old.type,
            roles: roles,
          );
        }

        Get.snackbar("Success", "Admin roles updated successfully",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", parsed['message'] ?? "Failed to update roles",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e, stackTrace) {
      debugPrint('Update error: $e');
      debugPrintStack(stackTrace: stackTrace);
      Get.snackbar("Error", "Network or server failure",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
