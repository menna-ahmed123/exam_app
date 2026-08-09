import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_params.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_event.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_state.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileChangePasswordViewBody extends StatefulWidget {
  const ProfileChangePasswordViewBody({super.key});

  @override
  State<ProfileChangePasswordViewBody> createState() =>
      _ProfileChangePasswordViewBodyState();
}

class _ProfileChangePasswordViewBodyState
    extends State<ProfileChangePasswordViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onUpdatePressed() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final params = ChangePasswordParams(
      oldPassword: _currentPasswordController.text.trim(),
      password: _newPasswordController.text.trim(),
      rePassword: _confirmPasswordController.text.trim(),
    );

    context.read<ProfileViewModel>().doEvent(
      ChangePasswordEvent(params: params),
    );
  }

  void _listener(BuildContext context, ProfileState state) {
    final changePasswordState = state.changePasswordState;

    if (changePasswordState.isLoading) {
      return;
    }

    if (changePasswordState.errorMessage.isNotEmpty) {
      buildSnackBar(
        context: context,
        message: changePasswordState.errorMessage,
        backgroundColor: AppPalette.error,
      );

      return;
    }

    if (changePasswordState.data != null) {
      buildSnackBar(
        context: context,
        message: AppStrings.passwordChangedSuccessfully,
        backgroundColor: AppPalette.primaryBlue,
      );

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
      listener: _listener,
      builder: (context, state) {
        final isLoading = state.changePasswordState.isLoading;

        return Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.appParSpace),
                  const AppBackHeader(title: AppStrings.changePassword),
                  const SizedBox(height: AppSpacing.sectionGap),
                  AppTextField(
                    controller: _currentPasswordController,
                    label: AppStrings.currentPassword,
                    hint: AppStrings.currentPassword,
                    obscureText: true,
                    validator: Validators.password,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.fieldGap),
                  AppTextField(
                    controller: _newPasswordController,
                    label: AppStrings.newPassword,
                    hint: AppStrings.newPassword,
                    obscureText: true,
                    validator: Validators.password,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.fieldGap),
                  AppTextField(
                    controller: _confirmPasswordController,
                    label: AppStrings.confirmPassword,
                    hint: AppStrings.confirmPassword,
                    obscureText: true,
                    validator: (value) {
                      return Validators.confirmPassword(
                        value,
                        _newPasswordController.text,
                      );
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: AppSpacing.buttonTopGap),
                  AppButton(
                    text: isLoading ? AppStrings.updating : AppStrings.update,
                    onPressed: isLoading ? null : _onUpdatePressed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
