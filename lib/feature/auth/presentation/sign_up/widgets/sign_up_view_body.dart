import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_event.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_state.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/widgets/side_by_side_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => SignUpViewBodyState();
}

class SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: SingleChildScrollView(child: _signUpForm()),
    );
  }

  Widget _signUpForm() {
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
      const AppBackHeader(title: AppStrings.signUp),
      const SizedBox(height: AppSpacing.sectionGap),
      _userNameField(),
      const SizedBox(height: AppSpacing.sectionGap),
      _nameFields(),
      const SizedBox(height: AppSpacing.sectionGap),
      _emailField(),
      const SizedBox(height: AppSpacing.sectionGap),
      _passwordFields(),
      const SizedBox(height: AppSpacing.sectionGap),
      _phoneField(),
      const SizedBox(height: AppSpacing.buttonTopGap),
      _signUpButton(),
      const SizedBox(height: AppSpacing.fieldGap),
      _loginFooter(),
    ];
  }

  Widget _userNameField() {
    return AppTextField(
      label: AppStrings.userName,
      hint: AppStrings.enterYourUserName,
      controller: userNameController,
      validator: Validators.userName,
    );
  }

  Widget _nameFields() {
    return SideBySideFields(
      leftLabel: AppStrings.firstName,
      leftHint: AppStrings.enterFirstName,
      rightLabel: AppStrings.lastName,
      rightHint: AppStrings.enterLastName,
      leftController: firstNameController,
      rightController: lastNameController,
    );
  }

  Widget _emailField() {
    return AppTextField(
      label: AppStrings.email,
      hint: AppStrings.enterYourEmail,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: Validators.email,
    );
  }

  Widget _passwordFields() {
    return SideBySideFields(
      leftLabel: AppStrings.password,
      leftHint: AppStrings.enterPassword,
      rightLabel: AppStrings.confirmPassword,
      rightHint: AppStrings.confirmPassword,
      leftController: passwordController,
      rightController: confirmPasswordController,
      leftObscureText: true,
      rightObscureText: true,
      leftValidator: Validators.password,
      rightValidator: (value) {
        return Validators.confirmPassword(value, passwordController.text);
      },
    );
  }

  Widget _phoneField() {
    return AppTextField(
      label: AppStrings.phoneNumber,
      hint: AppStrings.enterPhoneNumber,
      controller: phoneController,
      keyboardType: TextInputType.phone,
    );
  }

  Widget _signUpButton() {
    return BlocConsumer<SignUpViewModel, SignUpState>(
      listener: _onSignUpState,
      builder: (context, state) {
        return AppButton(
          isLoading: state.signUpState?.isLoading ?? false,
          text: AppStrings.signUp,
          onPressed: _submitSignUp,
        );
      },
    );
  }

  void _onSignUpState(BuildContext context, SignUpState state) {
    if (state.signUpState?.errorMessage.isNotEmpty ?? false) {
      buildSnackBar(
        context: context,
        message: state.signUpState?.errorMessage ?? '',
        backgroundColor: AppPalette.error,
      );
      return;
    }
    if (state.signUpState?.data != null) {
      context.read<AuthCubit>().setAuthenticated();
      context.go(AppRoutes.home);
    }
  }

  void _submitSignUp() {
    if (formKey.currentState!.validate()) {
      context.read<SignUpViewModel>().doEvent(
        MakeSignUp(signUpEntity: _buildSignUpEntity()),
      );
      return;
    }
    setState(() => autovalidateMode = AutovalidateMode.always);
  }

  SignUpEntity _buildSignUpEntity() {
    return SignUpEntity(
      username: userNameController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      rePassword: confirmPasswordController.text,
      phone: phoneController.text.trim(),
    );
  }

  Widget _loginFooter() {
    return AppFooterLink(
      onLinkPressed: () => context.pop(),
      prefixText: AppStrings.alreadyHaveAccount,
      linkText: AppStrings.login,
    );
  }
}
