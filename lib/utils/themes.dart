import 'package:flutter/material.dart';
import 'package:leo_rigging_dashboard/utils/appcolors.dart';
import 'package:leo_rigging_dashboard/utils/text_theme.dart';

class CAppTheme {
  CAppTheme._();

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.cPrimary,
      brightness: Brightness.light,
      primary: AppColors.cPrimary,
      surface: AppColors.cWhite,
      onPrimary: AppColors.cWhite,
      onSurface: AppColors.cWhite,
    ),
    scaffoldBackgroundColor: AppColors.cWhite,
    textTheme: CTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: CTextTheme.lightTextTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.cWhite,
        ),
        foregroundColor: AppColors.cWhite,

        backgroundColor: AppColors.cPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.cBlack),
  );

  // Dark Theme
}
