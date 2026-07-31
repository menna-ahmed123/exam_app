import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_screen_header.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => ForgetPasswordViewBodyState();
}

class ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
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
        title: AppStrings.forgetPasswordTitle,
        subtitle: AppStrings.forgetPasswordSubtitle,
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
    return BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
      listener: _onState,
      builder: (context, state) {
        return AppButton(
          text: AppStrings.continueText,
          isLoading: state.forgetPasswordState?.isLoading ?? false,
          onPressed: _submit,
        );
      },
    );
  }

  void _onState(BuildContext context, ForgetPasswordState state) {
    if (state.forgetPasswordState?.errorMessage.isNotEmpty ?? false) {
      buildSnackBar(
        context: context,
        message: state.forgetPasswordState?.errorMessage ?? '',
        backgroundColor: AppPalette.error,
      );
      return;
    }
    if (state.forgetPasswordState?.data != null) {
      context.push(
        AppRoutes.emailVerification,
        extra: emailController.text.trim(),
      );
    }
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      context.read<ForgetPasswordViewModel>().doEvent(
            MakeForgetPassword(email: emailController.text.trim()),
          );
      return;
    }
    setState(() => autoValidateMode = AutovalidateMode.always);
  }
}
