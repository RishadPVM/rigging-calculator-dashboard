import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:pinput/pinput.dart';

import 'forgot_password/confirm_password.dart';
import 'widget/logocard.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: AppColors.cBlack),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cGrey),
      ),
    );

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
                        "Verify your otp ",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Enter your details down below",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 40),
                      Pinput(
                        controller: otpController,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("Verify OTP"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConfirmPassword(),
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
