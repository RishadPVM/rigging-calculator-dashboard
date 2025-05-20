import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/view/auth/controller/auth_controller.dart';
import 'package:leo_rigging_dashboard/view/auth/forgot_password/verify_email.dart';

import '../../../widget/c_textfeild.dart';
import '../widget/logocard.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Form(
              key: authController.formKey,
              child: SizedBox(
                height: double.infinity,
                child: Center(
                  child: SizedBox(
                    width: 420,
                    child: Obx(
                      () =>  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to LEO Dashboard.\nLog in to see latest updates.",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "Enter your details down below",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 40),
                          CTextField(
                            labelText: 'E-mail',
                            suffixIcon: Icon(Icons.email_outlined),
                            keyboardType: TextInputType.emailAddress,
                            controller: authController.emailController,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CTextField(
                            labelText: 'Password',
                            suffixIcon: authController.isPasswordHide.value? IconButton(onPressed: () {
                              authController.isPasswordHide.value = false;
                            }, icon: Icon(Icons.visibility_off)) :  IconButton(onPressed: () {
                              authController.isPasswordHide.value = true;
                            }, icon: Icon(Icons.visibility_outlined)),
                            keyboardType: TextInputType.text,
                            controller: authController.passwordController,
                            obscureText: authController.isPasswordHide.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const VerifyEmail(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot password',
                                style: TextStyle(color: AppColors.cPrimary),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child:authController.isLoading.value ? Center(child: CircularProgressIndicator()) : ElevatedButton(
                              onPressed:authController.isLoading.value ? null : () async {
                                if (authController.formKey.currentState!.validate()) {
                                  await authController.login();
                                }
                              },
                              child: const Text("Log in"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Expanded(child: LogoCard()),
        ],
      ),
    );
  }
}
