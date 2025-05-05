import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';

class CTextTheme {
  CTextTheme._();

  // Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
       overflow:  TextOverflow.ellipsis,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.cBlack,
    ),
    headlineLarge: TextStyle(
       overflow:  TextOverflow.ellipsis,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.cBlack,
    ),
     headlineMedium: TextStyle(
       overflow:  TextOverflow.ellipsis,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.cBlack,
    ),
    bodyLarge: TextStyle(
       overflow:  TextOverflow.ellipsis,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.cBlack,
    ),
    bodyMedium: TextStyle(
       overflow:  TextOverflow.ellipsis,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.cBlack,
    ),
    bodySmall: TextStyle(
      // overflow:  TextOverflow.ellipsis,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.cBlack,
    ),
  );

  // Dark Text Theme
}
