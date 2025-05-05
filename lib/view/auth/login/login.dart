import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/view/auth/forgot_password/verify_email.dart';
import 'package:leo_rigging_dashboard/view/nav/nav.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';

import '../../../widget/c_textfeild.dart';
import '../widget/logocard.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: double.infinity,
              child: Center(
                child: SizedBox(
                  width: 420,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to LEO Dashboard.\nLog in to see latest updates.",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Enter your details down below",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 40),
                      CTextField(
                        labelText: 'E-mail',
                        suffixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.none,
                        controller: emailController,
                        obscureText: false,
                      ),
                      SizedBox(height: 16),
                      CTextField(
                        labelText: 'Password',
                        suffixIcon: Icons.visibility_off,
                        keyboardType: TextInputType.none,
                        controller: passwordController,
                        obscureText: true,
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
                      SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("Log in"),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const NavPage(),
                            ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: LogoCard()),
        ],
      ),
    );
  }
}
