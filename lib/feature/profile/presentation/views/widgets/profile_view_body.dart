import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_state.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:exam_app/feature/profile/presentation/views/widgets/profile_avater.dart';
import 'package:exam_app/feature/profile/presentation/views/widgets/profile_form.dart' show ProfileForm;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
      listener: (context, state) {
        final profile = state.profileState?.data;

        if (profile != null) {
          _usernameController.text = profile.username;
          _firstNameController.text = profile.firstName;
          _lastNameController.text = profile.lastName;
          _emailController.text = profile.email;
          _phoneController.text = profile.phone;

          _passwordController.text = '********';
        }
      },
      builder: (context, state) {
        if (state.profileState?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator());
        }

        if ((state.profileState?.errorMessage ?? '').isNotEmpty) {
          return Center(child: Text(state.profileState!.errorMessage));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.appParSpace),

                const AppBackHeader(title: AppStrings.profile),

                const SizedBox(height: AppSpacing.sectionGap),

                const Center(child: ProfileAvatar()),

                const SizedBox(height: AppSpacing.buttonTopGap),
                 ProfileForm(
                  enabled: false,
                  usernameController: _usernameController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  phoneController: _phoneController,
                ),
                const SizedBox(height: AppSpacing.buttonTopGap),

                AppButton(
                  text: AppStrings.update,
                  onPressed: () {
                    context.push(
                      AppRoutes.profileEdit,
                      extra: context.read<ProfileViewModel>(),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.sectionGap),
              ],
            ),
          ),
        );
      },
    );
  }
}
