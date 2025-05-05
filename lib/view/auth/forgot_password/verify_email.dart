import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/view/auth/verify_otp.dart';

import '../../../widget/c_textfeild.dart';
import '../widget/logocard.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
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
                        "Forgot your password",
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

                      SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("Send OTP"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyOtp(),
                              ),
                            );
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
