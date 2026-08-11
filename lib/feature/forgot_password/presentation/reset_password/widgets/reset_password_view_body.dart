import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/app/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/cubit/reset_password_event.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/cubit/reset_password_state.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _formChildren(),
        ),
      ),
    );
  }

  List<Widget> _formChildren() {
    return [
      const SizedBox(height: 56),
      const AppBackHeader(title: AppStrings.passwordFlowHeader),
      const SizedBox(height: AppSpacing.sectionGap),
      const AppScreenHeader(
        title: AppStrings.resetPassword,
        subtitle: AppStrings.resetPasswordHint,
      ),
      const SizedBox(height: AppSpacing.sectionGap),
      _newPasswordField(),
      const SizedBox(height: AppSpacing.fieldGap),
      _confirmPasswordField(),
      const Spacer(),
      _continueButton(),
      const SizedBox(height: AppSpacing.sectionGap),
    ];
  }

  Widget _newPasswordField() {
    return AppTextField(
      label: AppStrings.newPassword,
      hint: AppStrings.enterYourPassword,
      controller: newPasswordController,
      obscureText: true,
      textInputAction: TextInputAction.next,
      validator: Validators.password,
    );
  }

  Widget _confirmPasswordField() {
    return AppTextField(
      label: AppStrings.confirmPassword,
      hint: AppStrings.confirmPassword,
      controller: confirmPasswordController,
      obscureText: true,
      textInputAction: TextInputAction.done,
      validator: (value) {
        return Validators.confirmPassword(value, newPasswordController.text);
      },
    );
  }

  Widget _continueButton() {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: _onState,
      builder: (context, state) {
        return AppButton(
          text: AppStrings.continueText,
          isLoading: state.resetPasswordState?.isLoading ?? false,
          onPressed: _submit,
        );
      },
    );
  }

  void _onState(BuildContext context, ResetPasswordState state) {
    if (state.resetPasswordState?.errorMessage.isNotEmpty ?? false) {
      buildSnackBar(
        context: context,
        message: state.resetPasswordState?.errorMessage ?? '',
        backgroundColor: AppPalette.error,
      );
      return;
    }
    if (state.resetPasswordState?.data != null) {
      buildSnackBar(
        context: context,
        message: AppStrings.passwordResetSuccess,
        backgroundColor: AppPalette.primaryBlue,
      );
      context.go(AppRoutes.login);
    }
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().onEvent(
            ResetPasswordSubmitted(
              email: widget.email,
              newPassword: newPasswordController.text,
            ),
          );
      return;
    }
    setState(() => autovalidateMode = AutovalidateMode.always);
  }
}
