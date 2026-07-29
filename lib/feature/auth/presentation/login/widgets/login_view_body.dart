import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_checkbox_tile.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_event.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_state.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => LoginViewBodyState();
}

class LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: SingleChildScrollView(child: _loginForm()),
    );
  }

  Widget _loginForm() {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _formChildren(),
      ),
    );
  }

  List<Widget> _formChildren() {
    return [
      const SizedBox(height: 56),
      const AppBackHeader(title: AppStrings.login),
      const SizedBox(height: AppSpacing.sectionGap),
      _emailField(),
      const SizedBox(height: AppSpacing.sectionGap),
      _passwordField(),
      const SizedBox(height: AppSpacing.fieldGap),
      _optionsRow(),
      const SizedBox(height: AppSpacing.buttonTopGap),
      _loginButton(),
      const SizedBox(height: AppSpacing.fieldGap),
      _signUpFooter(),
    ];
  }

  Widget _emailField() {
    return AppTextField(
      label: AppStrings.email,
      hint: AppStrings.enterYourEmail,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      validator: Validators.email,
    );
  }

  Widget _passwordField() {
    return AppTextField(
      label: AppStrings.password,
      hint: AppStrings.enterYourPassword,
      controller: passwordController,
      obscureText: true,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      validator: Validators.password,
    );
  }

  Widget _optionsRow() {
    return Row(
      children: [
        AppCheckboxTile(
          label: AppStrings.rememberMe,
          value: rememberMe,
          onChanged: (bool? value) {
            setState(() => rememberMe = value ?? false);
          },
        ),
        const Spacer(),
        AppTextLink(
          onPressed: () => context.push(AppRoutes.forgetPassword),
          text: AppStrings.forgetPassword,
          color: AppPalette.primaryText,
        ),
      ],
    );
  }

  Widget _loginButton() {
    return BlocConsumer<LoginViewModel, LoginState>(
      listener: _onLoginState,
      builder: (context, state) {
        return AppButton(
          isLoading: state.loginState?.isLoading ?? false,
          onPressed: _submitLogin,
          text: AppStrings.login,
        );
      },
    );
  }

  void _onLoginState(BuildContext context, LoginState state) {
    if (state.loginState?.errorMessage.isNotEmpty ?? false) {
      buildSnackBar(
        context: context,
        message: state.loginState?.errorMessage ?? '',
        backgroundColor: AppPalette.error,
      );
      return;
    }
    if (state.loginState?.data != null) {
      context.read<AuthCubit>().setAuthenticated();
      context.go(AppRoutes.home);
    }
  }

  void _submitLogin() {
    if (formKey.currentState!.validate()) {
      context.read<LoginViewModel>().doEvent(
        MakeLogin(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
      return;
    }
    setState(() => autovalidateMode = AutovalidateMode.always);
  }

  Widget _signUpFooter() {
    return AppFooterLink(
      onLinkPressed: () => context.push(AppRoutes.signUp),
      prefixText: AppStrings.dontHaveAccount,
      linkText: AppStrings.signUp,
    );
  }
}
