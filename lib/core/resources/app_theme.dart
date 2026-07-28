import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    fontFamily: 'Inter',

    scaffoldBackgroundColor: AppColors.white,

    primaryColor: AppColors.primaryBlue,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      error: AppColors.error,
      surface: AppColors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: AppColors.primaryText),
    ),

    textTheme: TextTheme(
      displayLarge: AppTextStyles.styleSemiBold24(),
      titleLarge: AppTextStyles.styleMedium20(),
      titleMedium: AppTextStyles.styleMedium18(),
      bodyLarge: AppTextStyles.styleRegular16(),
      bodyMedium: AppTextStyles.styleRegular14(),
      bodySmall: AppTextStyles.styleRegular13().copyWith(color: AppColors.grey),
      labelSmall: AppTextStyles.styleRegular12().copyWith(
        color: AppColors.error,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: AppTextStyles.styleMedium16(),
      ),
    ),
  );
}
