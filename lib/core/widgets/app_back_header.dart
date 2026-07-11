import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackHeader extends StatelessWidget {
  const AppBackHeader({super.key, required this.title, this.onBackPressed});

  final String title;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBackPressed ?? () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryText,
            size: 20,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: AppTextStyles.styleSemiBold24(color: AppColors.primaryText),
        ),
      ],
    );
  }
}
