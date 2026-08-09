
import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/widgets/side_by_side_fields.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
        _buildUsernameField(),
        const SizedBox(height: AppSpacing.fieldGap),
        _buildNameFields(),
        const SizedBox(height: AppSpacing.fieldGap),
        _buildEmailField(),
        const SizedBox(height: AppSpacing.fieldGap),
        _buildPasswordField(context),
        const SizedBox(height: AppSpacing.fieldGap),
        _buildPhoneField(),
      ],
    );
  }

  Widget _buildUsernameField() {
    return AppTextField(
      controller: usernameController,
      label: AppStrings.userName,
      hint: '',
      enabled: enabled,
      validator: Validators.userName,
    );
  }

  Widget _buildNameFields() {
    return SideBySideFields(
       enabled: enabled,
      leftLabel: AppStrings.firstName,
      leftHint: '',
      rightLabel: AppStrings.lastName,
      rightHint: '',
      leftController: firstNameController,
      rightController: lastNameController,
      leftValidator: Validators.name,
      rightValidator: Validators.name,
    );
  }

  Widget _buildEmailField() {
    return AppTextField(
      controller: emailController,
      label: AppStrings.email,
      hint: '',
      enabled: enabled,
      validator: Validators.email,
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return AppTextField(
      controller: passwordController,
      label: AppStrings.password,
      hint: '',
      enabled: enabled,
      obscureText: true,
      validator: Validators.password,
      suffix: _buildChangePasswordButton(context),
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.push(
          AppRoutes.profileChangePassword,
          extra: context.read<ProfileViewModel>(),
        );
      },
      child: Text(
        AppStrings.changePassword,
        style: AppTextStyles.styleRegular13(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return AppTextField(
      controller: phoneController,
      label: AppStrings.phoneNumber,
      hint: '',
      enabled: enabled,
      validator: Validators.phone,
    );
  }
}

