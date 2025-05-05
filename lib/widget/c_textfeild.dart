import 'package:flutter/material.dart';

import '../utils/appcolors.dart';

class CTextField extends StatelessWidget {
  final String labelText;
  final IconData suffixIcon;
  final TextInputType keyboardType;
  final bool? obscureText;
  final TextEditingController? controller;

  const CTextField({
    super.key,
    required this.labelText,
    required this.suffixIcon,
     this.keyboardType = TextInputType.text,
     this.obscureText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.cBlack,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.cBlack),
        suffixIcon: Icon(suffixIcon),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.cGrey300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.cBlack),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText??false,
    );
  }
}