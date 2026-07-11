import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_checkbox_tile.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 56),
          const AppBackHeader(title: AppStrings.login),
          const SizedBox(height: AppSpacing.sectionGap),
          AppTextField(
            label: AppStrings.email,
            hint: AppStrings.enterYourEmail,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          AppTextField(
            label: AppStrings.password,
            hint: AppStrings.enterYourPassword,
          ),
          const SizedBox(height: AppSpacing.fieldGap),
          Row(
            children: [
              AppCheckboxTile(
                label: AppStrings.rememberMe,
                value: false,
                onChanged: (bool? v) {},
              ),
              const Spacer(),
              AppTextLink(
                text: AppStrings.forgetPassword,
                color: AppColors.primaryText,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.buttonTopGap),
          AppButton(text: AppStrings.login),
          const SizedBox(height: AppSpacing.fieldGap),
          AppFooterLink(
            onLinkPressed: () {
              context.push(AppRoutes.signUp);
            },
            prefixText: AppStrings.dontHaveAccount,
            linkText: AppStrings.signUp,
          ),
        ],
      ),
    );
  }
}
