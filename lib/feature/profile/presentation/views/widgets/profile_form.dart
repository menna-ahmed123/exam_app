import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/widgets/side_by_side_fields.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    super.key,
    required this.enabled,
    required this.usernameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
  });

  final bool enabled;

  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: usernameController,
          label: AppStrings.userName,
          hint: '',
          enabled: enabled,
        ),

        const SizedBox(height: AppSpacing.fieldGap),

        SideBySideFields(
          leftLabel: AppStrings.firstName,
          leftHint: '',
          rightLabel: AppStrings.lastName,
          rightHint: '',
          leftController: firstNameController,
          rightController: lastNameController,
        ),

        const SizedBox(height: AppSpacing.fieldGap),

        AppTextField(
          controller: emailController,
          label: AppStrings.email,
          hint: '',
          enabled: enabled,
        ),

        const SizedBox(height: AppSpacing.fieldGap),

        AppTextField(
          controller: passwordController,
          label: AppStrings.password,
          hint: '',
          enabled: enabled,
          obscureText: true,
          suffix: TextButton(
            onPressed: () {
          
            },
            child: Text(AppStrings.changePassword,
              style: AppTextStyles.styleRegular13(color: Theme.of(context).primaryColor),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.fieldGap),

        AppTextField(
          controller: phoneController,
          label: AppStrings.phoneNumber,
          hint: '',
          enabled: enabled,
        ),
      ],
    );
  }
}
