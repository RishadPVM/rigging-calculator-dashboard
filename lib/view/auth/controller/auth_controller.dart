import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/core/LoginResponce/global_user.dart';
import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';
import 'package:leo_rigging_dashboard/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../nav/nav.dart';

class AuthController extends GetxController {
  final apiService = ApiService();

  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  var isLoading = false.obs;
  var isPasswordHide = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> saveLoginData(LoginResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('adminData', jsonEncode(user.toJson()));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('adminData');
    GlobalUser().clearUser();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    isLoading.value = true;

    try {
      final response = await apiService.post(
        ApiUrl.loginPost,
        headers: _defaultHeaders,
        body: {"email": email, "password": password},
      );

      // Handle decoded response (already parsed from _handleResponse)
      if (response['status'] == true && response['token'] != null) {
        final user = LoginResponse.fromJson(response);
        await saveLoginData(user);
        GlobalUser().setUser(user);
        emailController.clear();
        passwordController.clear();
        Get.offAll(() => const NavPage());
      } else {
        Get.snackbar(
          'Login Failed',
          response['error'] ?? 'Invalid email or password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
