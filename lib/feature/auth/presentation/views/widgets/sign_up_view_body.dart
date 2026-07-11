
import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/auth/presentation/views/widgets/side_by_side_fields.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
      child: Column(
        children: [
      
           SizedBox(height: 56),
          AppBackHeader(title: AppStrings.signUp),
                    SizedBox(height: AppSpacing.sectionGap),

          AppTextField(label: AppStrings.userName, hint: AppStrings.enterYourUserName),
          SizedBox(height: AppSpacing.sectionGap,),
          SideBySideFields(leftLabel: AppStrings.firstName, leftHint: AppStrings.enterFirstName, rightLabel: AppStrings.lastName, rightHint: AppStrings.enterLastName),
                    SizedBox(height: AppSpacing.sectionGap),
                    AppTextField(
            label: AppStrings.email,
            hint: AppStrings.enterYourEmail,
          ),
       SizedBox(height: AppSpacing.sectionGap),

        SideBySideFields(leftLabel: AppStrings.password, leftHint: AppStrings.enterPassword, rightLabel: AppStrings.confirmPassword, rightHint: AppStrings.confirmPassword),
         SizedBox(height: AppSpacing.sectionGap),

         AppTextField(
            label: AppStrings.phoneNumber,
            hint: AppStrings.enterPhoneNumber,
          ),
          SizedBox(height: AppSpacing.sectionGap),
                              SizedBox(height: AppSpacing.buttonTopGap),
          AppButton(text: AppStrings.signUp),
                    SizedBox(height: AppSpacing.fieldGap),
          AppFooterLink(
            onLinkPressed: () {
              context.pop();
            },
            prefixText: AppStrings.alreadyHaveAccount, linkText: AppStrings.login) 




          
        ],
      ),
    );
  }
}

