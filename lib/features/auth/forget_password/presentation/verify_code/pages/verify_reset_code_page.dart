import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/ui_strings.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:exam_app/core/widgets/otp_input_field.dart';
import 'package:exam_app/features/auth/forget_password/presentation/verify_code/cubit/verify_reset_code_cubit.dart';
import 'package:exam_app/features/auth/forget_password/presentation/verify_code/cubit/verify_reset_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyResetCodePage extends StatelessWidget {
  const VerifyResetCodePage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<VerifyResetCodeCubit, VerifyResetCodeState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            if (state.isSuccess) {
              context.push(AppRoutes.resetPassword, extra: state.email);
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
                    title: AppStrings.emailVerification,
                    subtitle: AppStrings.emailVerificationSubtitle,
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  OtpInputField(
                    key: ValueKey(state.resetToken),
                    errorText: state.codeError,
                    onChanged: context.read<VerifyResetCodeCubit>().codeChanged,
                    onCompleted: (_) =>
                        context.read<VerifyResetCodeCubit>().submit(),
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.didntReceiveCode,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 4),
                      AppTextLink(
                        text: AppStrings.resend,
                        onPressed: state.isResending
                            ? null
                            : context.read<VerifyResetCodeCubit>().resendCode,
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
