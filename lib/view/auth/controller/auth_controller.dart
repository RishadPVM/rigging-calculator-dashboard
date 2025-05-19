import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:leo_rigging_dashboard/core/api/api_service.dart';
import 'package:leo_rigging_dashboard/core/api/api_url.dart';

class AuthController extends GetxController {
  ApiService apiService = ApiService();

  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  var isLoading = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    emailError.value = '';
    passwordError.value = '';

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Input validation
    if (email.isEmpty) {
      emailError.value = 'Please enter your email';
      return;
    }
    if (password.isEmpty) {
      passwordError.value = 'Please enter your password';
      return;
    }

    // Email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emailError.value = 'Please enter a valid email';
      return;
    }

    isLoading.value = true;
    try {
      apiService.post(
        ApiUrl.loginPost,
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );
    } catch (e) {
      // Handle network or server errors
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
