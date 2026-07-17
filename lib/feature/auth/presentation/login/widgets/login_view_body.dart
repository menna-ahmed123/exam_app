import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/routing/app_router.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_checkbox_tile.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/core/widgets/app_text_link.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_event.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_state.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String email = '', password = '';
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 56),
              AppBackHeader(title: AppStrings.login),
              SizedBox(height: AppSpacing.sectionGap),
              AppTextField(
                label: AppStrings.email,
                hint: AppStrings.enterYourEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                validator: Validators.email,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: AppSpacing.sectionGap),

              AppTextField(
                label: AppStrings.password,
                hint: AppStrings.enterYourPassword,
                obscureText: true,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                validator: Validators.password,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: AppSpacing.fieldGap),

              Row(
                children: [
                  AppCheckboxTile(
                    label: AppStrings.rememberMe,
                    value: rememberMe,
                    onChanged: (bool? v) {
                      setState(() {
                        rememberMe = v ?? false;
                      });
                    },
                  ),
                  Spacer(),
                  AppTextLink(
                    onPressed: () {},
                    text: AppStrings.forgetPassword,
                    color: AppColors.primaryText,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.buttonTopGap),
              BlocConsumer<LoginViewModel, LoginState>(
                listener: (context, state) {
                  if (state.loginState?.errorMessage.isNotEmpty ?? false) {
                    buildSnackBar(
                      context: context,
                      message: state.loginState?.errorMessage ?? '',
                      backgroundColor: AppColors.error,
                    );
                  } else if (state.loginState?.data != null) {
                    context.push(AppRoutes.home);
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    isLoading: state.loginState?.isLoading ?? false,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<LoginViewModel>().doEvent(
                          MakeLogin(email: email, password: password),
                        );
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: AppStrings.login,
                  );
                },
              ),
              SizedBox(height: AppSpacing.fieldGap),

              AppFooterLink(
                onLinkPressed: () {
                  context.push(AppRoutes.signUp);
                },
                prefixText: AppStrings.dontHaveAccount,
                linkText: AppStrings.signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
