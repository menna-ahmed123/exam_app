import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_checkbox_tile.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:flutter/material.dart';

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
          SizedBox(height: 56),
          AppBackHeader(title: AppStrings.login),
          SizedBox(height: AppSpacing.sectionGap),
          AppTextField(
            label: AppStrings.email,
            hint: AppStrings.enterYourEmail,
          ),
          SizedBox(height: AppSpacing.sectionGap),

          AppTextField(
            label: AppStrings.password,
            hint: AppStrings.enterYourPassword,
          ),
          SizedBox(height: AppSpacing.fieldGap),

          Row(
            children: [
              AppCheckboxTile(
                label: AppStrings.rememberMe,
                value: false,
                onChanged: (bool? v) {},
              ),
              Spacer(),
              AppTextLink(
                text: AppStrings.forgetPassword,
                color: AppColors.primaryText,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.buttonTopGap),
          AppButton(text: AppStrings.login),
          SizedBox(height: AppSpacing.fieldGap),

          AppFooterLink(
            onLinkPressed: () {},
            prefixText: AppStrings.dontHaveAccount,
            linkText: AppStrings.signUp,
          ),
        ],
      ),
    );
  }
}
