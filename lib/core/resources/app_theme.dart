import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppPalette.white,
      primaryColor: AppPalette.primaryBlue,
      colorScheme: _colorScheme,
      appBarTheme: _appBarTheme,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static const ColorScheme _colorScheme = ColorScheme.light(
    primary: AppPalette.primaryBlue,
    error: AppPalette.error,
    surface: AppPalette.white,
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppPalette.white,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: AppPalette.primaryText),
  );

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppTextStyles.styleSemiBold24(),
      titleLarge: AppTextStyles.styleMedium20(),
      titleMedium: AppTextStyles.styleMedium18(),
      bodyLarge: AppTextStyles.styleRegular16(),
      bodyMedium: AppTextStyles.styleRegular14(),
      bodySmall: AppTextStyles.styleRegular13().copyWith(color: AppPalette.grey),
      labelSmall: AppTextStyles.styleRegular12().copyWith(
        color: AppPalette.error,
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.primaryBlue,
        foregroundColor: AppPalette.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: AppTextStyles.styleMedium16(),
      ),
    );
  }
}
