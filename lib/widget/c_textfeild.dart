import 'package:flutter/material.dart';

import '../utils/appcolors.dart';

class CTextField extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool? obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CTextField({
    super.key,
    required this.labelText,
     this.suffixIcon,
     this.keyboardType = TextInputType.text,
     this.obscureText,
    this.controller,
    this.onChanged,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      cursorColor: AppColors.cBlack,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.cBlack),
        suffixIcon:  suffixIcon,
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