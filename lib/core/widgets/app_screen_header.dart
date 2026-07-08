import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });

  final String title;
  final String? subtitle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: textAlign,
          style: AppTextStyles.styleSemiBold24(color: AppColors.primaryText),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: AppTextStyles.styleRegular14().copyWith(
              color: AppColors.grey,
            ),
          ),
        ],
      ],
    );
  }
}
