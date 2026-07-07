import 'package:exam_app/core/utils/font_weight_helper.dart';
import 'package:flutter/material.dart';


class AppTextStyles {
  AppTextStyles._();

  static TextStyle styleSemiBold24({Color? color}) {
    return TextStyle(
      fontSize: 24,
     // color: color ?? AppColors.mainText,
      fontWeight: FontWeightHelper.semiBold,
    );
  }

  static TextStyle styleMedium20() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeightHelper.medium,
    );
  }

  static TextStyle styleMedium18() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeightHelper.medium,
    );
  }


  static TextStyle styleMedium16({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeightHelper.medium,
    );
  }

  static TextStyle styleRegular16({Color? color}) {
    return TextStyle(
      fontSize: 16,
      //color: color ?? AppColors.mainText,
      fontWeight: FontWeightHelper.regular,
    );
  }

  static TextStyle styleRegular14() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeightHelper.regular,
    );
  }

  static TextStyle styleRegular13({Color? color}) {
    return TextStyle(
      fontSize: 13,
     // color: color ?? AppColors.mainText,
      fontWeight: FontWeightHelper.regular,
    );
  }

  static TextStyle styleRegular12() {
    return TextStyle(
      fontSize: 12,
      
      fontWeight: FontWeightHelper.regular,
    );
  }
}
