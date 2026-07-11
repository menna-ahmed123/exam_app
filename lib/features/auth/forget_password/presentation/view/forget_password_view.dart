import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            if (state.isSuccess) {
              context.push(AppRoutes.emailVerification, extra: state.email);
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
                    title: AppStrings.forgetPasswordTitle,
                    subtitle: AppStrings.forgetPasswordSubtitle,
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  AppTextField(
                    label: AppStrings.email,
                    hint: AppStrings.enterYourEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    errorText: state.emailError,
                    onChanged: context.read<ForgetPasswordCubit>().emailChanged,
                  ),
                  const Spacer(),
                  AppButton(
                    text: AppStrings.continueText,
                    isLoading: state.isLoading,
                    onPressed: state.canSubmit
                        ? context.read<ForgetPasswordCubit>().submit
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
