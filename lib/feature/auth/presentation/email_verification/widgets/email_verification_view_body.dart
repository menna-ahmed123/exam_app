import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:exam_app/core/widgets/otp_input_field.dart';
import 'package:exam_app/feature/auth/presentation/email_verification/view_model/email_verification_event.dart';
import 'package:exam_app/feature/auth/presentation/email_verification/view_model/email_verification_state.dart';
import 'package:exam_app/feature/auth/presentation/email_verification/view_model/email_verification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationViewBody extends StatefulWidget {
  const EmailVerificationViewBody({super.key, required this.email});

  final String email;

  @override
  State<EmailVerificationViewBody> createState() =>
      _EmailVerificationViewBodyState();
}

class _EmailVerificationViewBodyState extends State<EmailVerificationViewBody> {
  String code = '';
  String? codeError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 56),
          const AppBackHeader(title: AppStrings.passwordFlowHeader),
          const SizedBox(height: AppSpacing.sectionGap),
          const AppScreenHeader(
            title: AppStrings.emailVerification,
            subtitle: AppStrings.emailVerificationSubtitle,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          BlocConsumer<EmailVerificationViewModel, EmailVerificationState>(
            listener: (context, state) {
              if (state.emailVerificationState?.errorMessage.isNotEmpty ??
                  false) {
                setState(() {
                  codeError = state.emailVerificationState?.errorMessage;
                });
              } else if (state.emailVerificationState?.data != null) {
                context.push(AppRoutes.resetPassword, extra: widget.email);
              }

              if (state.resendCodeState?.errorMessage.isNotEmpty ?? false) {
                buildSnackBar(
                  context: context,
                  message: state.resendCodeState?.errorMessage ?? '',
                  backgroundColor: AppColors.error,
                );
              } else if (state.resendCodeState?.data != null) {
                setState(() {
                  code = '';
                  codeError = null;
                });
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  OtpInputField(
                    key: ValueKey(state.resetToken),
                    errorText: codeError,
                    onChanged: (value) {
                      code = value;
                      if (codeError != null) {
                        setState(() => codeError = null);
                      }
                    },
                    onCompleted: (value) {
                      final error = Validators.resetCode(value);
                      if (error != null) {
                        setState(() => codeError = error);
                        return;
                      }
                      context.read<EmailVerificationViewModel>().doEvent(
                            MakeVerifyResetCode(resetCode: value),
                          );
                    },
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
                        onPressed: state.resendCodeState?.isLoading ?? false
                            ? null
                            : () {
                                context
                                    .read<EmailVerificationViewModel>()
                                    .doEvent(
                                      MakeResendCode(email: widget.email),
                                    );
                              },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
