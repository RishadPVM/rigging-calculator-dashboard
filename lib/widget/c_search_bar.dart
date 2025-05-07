
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/appcolors.dart';
import '../utils/assets.dart';

class CsearchBar extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final double width;
  const CsearchBar({
    super.key, required this.hintText,
     this.onChanged,
     this.width=300,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: TextField(
        cursorColor: AppColors.cBlack,
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.cGrey100,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.cGrey, fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              Assets.searchIcon,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(AppColors.cGrey, BlendMode.srcIn),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
