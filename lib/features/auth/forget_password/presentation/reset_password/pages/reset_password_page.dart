import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/features/auth/forget_password/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/reset_password/cubit/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            if (state.isSuccess) {
              context.go(AppRoutes.login);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset successfully. Please login.'),
                ),
              );
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppBackHeader(title: AppStrings.passwordFlowHeader),
                  const SizedBox(height: AppSpacing.sectionGap),
                  const AppScreenHeader(
                    title: AppStrings.resetPassword,
                    subtitle: AppStrings.resetPasswordHint,
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  AppTextField(
                    label: AppStrings.newPassword,
                    hint: AppStrings.enterYourPassword,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    errorText: state.newPasswordError,
                    onChanged:
                        context.read<ResetPasswordCubit>().newPasswordChanged,
                  ),
                  const SizedBox(height: AppSpacing.fieldGap),
                  AppTextField(
                    label: AppStrings.confirmPassword,
                    hint: AppStrings.confirmPassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    errorText: state.confirmPasswordError,
                    onChanged: context
                        .read<ResetPasswordCubit>()
                        .confirmPasswordChanged,
                  ),
                  const Spacer(),
                  AppButton(
                    text: AppStrings.continueText,
                    isLoading: state.isLoading,
                    onPressed: state.canSubmit
                        ? context.read<ResetPasswordCubit>().submit
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
