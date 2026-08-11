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
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/cubit/forgot_password_event.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/cubit/forgot_password_state.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    emailController.dispose();
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
        autovalidateMode: autoValidateMode,
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
        title: AppStrings.forgotPasswordTitle,
        subtitle: AppStrings.forgotPasswordSubtitle,
      ),
      const SizedBox(height: AppSpacing.sectionGap),
      _emailField(),
      const Spacer(),
      _continueButton(),
      const SizedBox(height: AppSpacing.sectionGap),
    ];
  }

  Widget _emailField() {
    return AppTextField(
      label: AppStrings.email,
      hint: AppStrings.enterYourEmail,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.email],
      validator: Validators.email,
    );
  }

  Widget _continueButton() {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: _onState,
      builder: (context, state) {
        return AppButton(
          text: AppStrings.continueText,
          isLoading: state.forgotPasswordState?.isLoading ?? false,
          onPressed: _submit,
        );
      },
    );
  }

  void _onState(BuildContext context, ForgotPasswordState state) {
    if (state.forgotPasswordState?.errorMessage.isNotEmpty ?? false) {
      buildSnackBar(
        context: context,
        message: state.forgotPasswordState?.errorMessage ?? '',
        backgroundColor: AppPalette.error,
      );
      return;
    }
    if (state.forgotPasswordState?.data != null) {
      context.push(
        AppRoutes.emailVerification,
        extra: emailController.text.trim(),
      );
    }
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().onEvent(
            ForgotPasswordSubmitted(email: emailController.text.trim()),
          );
      return;
    }
    setState(() => autoValidateMode = AutovalidateMode.always);
  }
}
