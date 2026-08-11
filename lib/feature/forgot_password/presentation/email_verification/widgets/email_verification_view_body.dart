import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/app/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:exam_app/core/widgets/otp_input_field.dart';
import 'package:exam_app/feature/forgot_password/presentation/email_verification/cubit/email_verification_event.dart';
import 'package:exam_app/feature/forgot_password/presentation/email_verification/cubit/email_verification_state.dart';
import 'package:exam_app/feature/forgot_password/presentation/email_verification/cubit/email_verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationViewBody extends StatefulWidget {
  const EmailVerificationViewBody({super.key, required this.email});

  final String email;

  @override
  State<EmailVerificationViewBody> createState() {
    return _EmailVerificationViewBodyState();
  }
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
        children: _pageChildren(),
      ),
    );
  }

  List<Widget> _pageChildren() {
    return [
      const SizedBox(height: 56),
      const AppBackHeader(title: AppStrings.passwordFlowHeader),
      const SizedBox(height: AppSpacing.sectionGap),
      const AppScreenHeader(
        title: AppStrings.emailVerification,
        subtitle: AppStrings.emailVerificationSubtitle,
      ),
      const SizedBox(height: AppSpacing.sectionGap),
      _otpSection(),
      const Spacer(),
    ];
  }

  Widget _otpSection() {
    return BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
      listener: _onState,
      builder: (context, state) {
        return Column(
          children: [
            OtpInputField(
              key: ValueKey(state.resetToken),
              errorText: codeError,
              onChanged: _onCodeChanged,
              onCompleted: _onCodeCompleted,
            ),
            const SizedBox(height: AppSpacing.sectionGap),
            _resendRow(state),
          ],
        );
      },
    );
  }

  void _onCodeChanged(String value) {
    code = value;
    if (codeError != null) {
      setState(() => codeError = null);
    }
  }

  void _onCodeCompleted(String value) {
    final error = Validators.resetCode(value);
    if (error != null) {
      setState(() => codeError = error);
      return;
    }
    context.read<EmailVerificationCubit>().onEvent(
          VerifyResetCodeSubmitted(resetCode: value),
        );
  }

  Widget _resendRow(EmailVerificationState state) {
    final isLoading = state.resendCodeState?.isLoading ?? false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.didntReceiveCode,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 4),
        AppTextLink(
          text: AppStrings.resend,
          onPressed: isLoading ? null : _onResendPressed,
        ),
      ],
    );
  }

  void _onResendPressed() {
    context.read<EmailVerificationCubit>().onEvent(
          ResendCodeRequested(email: widget.email),
        );
  }

  void _onState(BuildContext context, EmailVerificationState state) {
    _handleVerifyState(state);
    _handleResendState(state);
  }

  void _handleVerifyState(EmailVerificationState state) {
    if (state.emailVerificationState?.errorMessage.isNotEmpty ?? false) {
      setState(() {
        codeError = state.emailVerificationState?.errorMessage;
      });
      return;
    }
    if (state.emailVerificationState?.data != null) {
      context.push(AppRoutes.resetPassword, extra: widget.email);
    }
  }

  void _handleResendState(EmailVerificationState state) {
    if (state.resendCodeState?.errorMessage.isNotEmpty ?? false) {
      buildSnackBar(
        context: context,
        message: state.resendCodeState?.errorMessage ?? '',
        backgroundColor: AppPalette.error,
      );
      return;
    }
    if (state.resendCodeState?.data != null) {
      setState(() {
        code = '';
        codeError = null;
      });
    }
  }
}
