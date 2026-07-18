import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_colors.dart';
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
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 56),
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
              autofillHints: const [AutofillHints.email],
              validator: Validators.email,
              onChanged: (value) {
                email = value;
              },
            ),
            const Spacer(),
            BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
              listener: (context, state) {
                if (state.forgetPasswordState?.errorMessage.isNotEmpty ??
                    false) {
                  buildSnackBar(
                    context: context,
                    message: state.forgetPasswordState?.errorMessage ?? '',
                    backgroundColor: AppColors.error,
                  );
                } else if (state.forgetPasswordState?.data != null) {
                  context.push(
                    AppRoutes.emailVerification,
                    extra: email.trim(),
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  text: AppStrings.continueText,
                  isLoading: state.forgetPasswordState?.isLoading ?? false,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgetPasswordViewModel>().doEvent(
                            MakeForgetPassword(email: email.trim()),
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
            const SizedBox(height: AppSpacing.sectionGap),
          ],
        ),
      ),
    );
  }
}
