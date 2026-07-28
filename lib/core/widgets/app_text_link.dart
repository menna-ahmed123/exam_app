import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTextLink extends StatelessWidget {
  const AppTextLink({
    super.key,
    required this.text,
    this.onPressed,
    this.underline = true,
    this.color,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool underline;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: AppTextStyles.styleRegular14().copyWith(
          color: color ?? AppColors.primaryBlue,
          decoration: underline ? TextDecoration.underline : null,
          decorationColor: color ?? AppColors.primaryBlue,
        ),
      ),
    );
  }
}
