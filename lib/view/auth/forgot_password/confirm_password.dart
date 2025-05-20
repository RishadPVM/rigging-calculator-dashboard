import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/view/auth/login/login.dart';

import '../../../widget/c_textfeild.dart';
import '../widget/logocard.dart';

class ConfirmPassword extends StatelessWidget {
  const ConfirmPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController confirmPassword = TextEditingController();
    final TextEditingController newPassword = TextEditingController();

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: 420,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set new password.",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Enter your new password down below",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 40),
                        CTextField(
                          labelText: 'New password',
                          suffixIcon: Icon(Icons.visibility_off),
                          keyboardType: TextInputType.none,
                          controller: newPassword,
                          obscureText: true,
                        ),
                        SizedBox(height: 16),
                        CTextField(
                          labelText: 'Confirm password',
                          suffixIcon: Icon(Icons.visibility_off),
                          keyboardType: TextInputType.none,
                          controller: confirmPassword,
                          obscureText: true,
                        ),
                  
                        SizedBox(height: 40),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text("Confirm"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
          Expanded(child: LogoCard()),
        ],
      ),
    );
  }
}
