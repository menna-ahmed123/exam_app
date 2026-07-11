import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/features/auth/sign_up/presentation/widgets/side_by_side_fields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        children: [
          const SizedBox(height: 56),
          const AppBackHeader(title: AppStrings.signUp),
          const SizedBox(height: AppSpacing.sectionGap),
          AppTextField(
            label: AppStrings.userName,
            hint: AppStrings.enterYourUserName,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          const SideBySideFields(
            leftLabel: AppStrings.firstName,
            leftHint: AppStrings.enterFirstName,
            rightLabel: AppStrings.lastName,
            rightHint: AppStrings.enterLastName,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          AppTextField(
            label: AppStrings.email,
            hint: AppStrings.enterYourEmail,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          const SideBySideFields(
            leftLabel: AppStrings.password,
            leftHint: AppStrings.enterPassword,
            rightLabel: AppStrings.confirmPassword,
            rightHint: AppStrings.confirmPassword,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          AppTextField(
            label: AppStrings.phoneNumber,
            hint: AppStrings.enterPhoneNumber,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          const SizedBox(height: AppSpacing.buttonTopGap),
          AppButton(text: AppStrings.signUp),
          const SizedBox(height: AppSpacing.fieldGap),
          AppFooterLink(
            onLinkPressed: () {
              context.pop();
            },
            prefixText: AppStrings.alreadyHaveAccount,
            linkText: AppStrings.login,
          ),
        ],
      ),
    );
  }
}
