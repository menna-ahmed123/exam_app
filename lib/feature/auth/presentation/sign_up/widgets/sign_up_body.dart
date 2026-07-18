import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_footer_link.dart';
import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_event.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_state.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/widgets/side_by_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String userName = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String phone = '';

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
              const SizedBox(height: 56),
              AppBackHeader(title: AppStrings.signUp),
              const SizedBox(height: AppSpacing.sectionGap),

              AppTextField(
                label: AppStrings.userName,
                hint: AppStrings.enterYourUserName,
                validator: Validators.userName,
                onChanged: (value) {
                  userName = value;
                },
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              SideBySideFields(
                leftLabel: AppStrings.firstName,
                leftHint: AppStrings.enterFirstName,
                rightLabel: AppStrings.lastName,
                rightHint: AppStrings.enterLastName,
                onLeftChanged: (value) {
                  firstName = value;
                },
                onRightChanged: (value) {
                  lastName = value;
                },
                
               
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              AppTextField(
                label: AppStrings.email,
                hint: AppStrings.enterYourEmail,
                validator: Validators.email,
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              SideBySideFields(
                
                leftLabel: AppStrings.password,
                leftHint: AppStrings.enterPassword,
                rightLabel: AppStrings.confirmPassword,
                rightHint: AppStrings.confirmPassword,
                onLeftChanged: (value) {
                  password = value;
                },
                onRightChanged: (value) {
                  confirmPassword = value;
                },
               
                rightValidator: (value) {
                  return Validators.confirmPassword(value, password);
                },
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              AppTextField(
                label: AppStrings.phoneNumber,
                hint: AppStrings.enterPhoneNumber,
                onChanged: (value) {
                  phone = value;
                },
              ),
              const SizedBox(height: AppSpacing.buttonTopGap),

              BlocConsumer<SignUpViewModel, SignUpState>(
                listener: (context, state) {
                  if (state.signUpState?.errorMessage.isNotEmpty ?? false) {
                    buildSnackBar(
                      context: context,
                      message: state.signUpState?.errorMessage ?? '',
                      backgroundColor: AppColors.error,
                    );
                  } else if (state.signUpState?.data != null) {
                    context.pop();
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    isLoading: state.signUpState?.isLoading ?? false,
                    text: AppStrings.signUp,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final signUpEntity = SignUpEntity(
                          username: userName,
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          password: password,
                          rePassword: confirmPassword,
                          phone: phone,
                        );

                        context.read<SignUpViewModel>().doEvent(
                          MakeSignUp(signUpEntity: signUpEntity),
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

              const SizedBox(height: AppSpacing.fieldGap),

              AppFooterLink(
                onLinkPressed: () {
                  context.pop();
                },
                prefixText: AppStrings.alreadyHaveAccount,
                linkText: AppStrings.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
