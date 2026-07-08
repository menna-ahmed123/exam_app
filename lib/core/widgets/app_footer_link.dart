import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:flutter/material.dart';

class AppFooterLink extends StatelessWidget {
  const AppFooterLink({
    super.key,
    required this.prefixText,
    required this.linkText,
    this.onLinkPressed,
  });

  final String prefixText;
  final String linkText;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prefixText,
          style: AppTextStyles.styleRegular14().copyWith(
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(width: 4),
        AppTextLink(
          text: linkText,
          onPressed: onLinkPressed,
        ),
      ],
    );
  }
}
