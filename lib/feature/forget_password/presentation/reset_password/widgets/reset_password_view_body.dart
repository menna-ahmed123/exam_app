import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/auth/presentation/reset_password/view_model/reset_password_event.dart';
import 'package:exam_app/feature/auth/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:exam_app/feature/auth/presentation/reset_password/view_model/reset_password_view_model.dart';
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
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String newPassword = '';
  String confirmPassword = '';

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
          children: [
            const SizedBox(height: 56),
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
              validator: Validators.password,
              onChanged: (value) {
                newPassword = value;
              },
            ),
            const SizedBox(height: AppSpacing.fieldGap),
            AppTextField(
              label: AppStrings.confirmPassword,
              hint: AppStrings.confirmPassword,
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) =>
                  Validators.confirmPassword(value, newPassword),
              onChanged: (value) {
                confirmPassword = value;
              },
            ),
            const Spacer(),
            BlocConsumer<ResetPasswordViewModel, ResetPasswordState>(
              listener: (context, state) {
                if (state.resetPasswordState?.errorMessage.isNotEmpty ??
                    false) {
                  buildSnackBar(
                    context: context,
                    message: state.resetPasswordState?.errorMessage ?? '',
                    backgroundColor: AppColors.error,
                  );
                } else if (state.resetPasswordState?.data != null) {
                  buildSnackBar(
                    context: context,
                    message: AppStrings.passwordResetSuccess,
                    backgroundColor: AppColors.primaryBlue,
                  );
                  context.go(AppRoutes.login);
                }
              },
              builder: (context, state) {
                return AppButton(
                  text: AppStrings.continueText,
                  isLoading: state.resetPasswordState?.isLoading ?? false,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ResetPasswordViewModel>().doEvent(
                            MakeResetPassword(
                              email: widget.email,
                              newPassword: newPassword,
                            ),
                          );
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.sectionGap),
          ],
        ),
      ),
    );
  }
}
