import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_event.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_state.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:exam_app/feature/profile/presentation/views/widgets/profile_avater.dart';
import 'package:exam_app/feature/profile/presentation/views/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // بنملى الفورم بالبيانات الحالية من نفس الـ Cubit
    final profile = context.read<ProfileViewModel>().state.profileState?.data;
    if (profile != null) {
      _usernameController.text = profile.username;
      _firstNameController.text = profile.firstName;
      _lastNameController.text = profile.lastName;
      _emailController.text = profile.email;
      _phoneController.text = profile.phone;
      _passwordController.text = '********';
    }
  }

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

  void _onUpdatePressed() {
    final params = UpdateProfileParams(
      username: _usernameController.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    context.read<ProfileViewModel>().doEvent(
      UpdateProfileEvent(params: params),
    );
  }

  @override
 Widget build(BuildContext context) {
    return BlocListener<ProfileViewModel, ProfileState>(
      listenWhen: (previous, current) =>
          previous.updateProfileState != current.updateProfileState,
      listener: (context, state) {
        final updateState = state.updateProfileState;

        if (updateState == null) return;

        if (!updateState.isLoading &&
            updateState.errorMessage.isEmpty &&
            updateState.data != null) {
         context.pop();
        }

        if (updateState.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(updateState.errorMessage)));
        }
      },
      child: Scaffold(
        body: BlocBuilder<ProfileViewModel, ProfileState>(
          builder: (context, state) {
            final isLoading = state.updateProfileState?.isLoading ?? false;
        
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.appParSpace),
                    const AppBackHeader(title: AppStrings.editProfile),
                    const SizedBox(height: AppSpacing.sectionGap),
                    const Center(child: ProfileAvatar()),
                     const SizedBox(height: AppSpacing.buttonTopGap),
                    ProfileForm(
                      enabled: true,
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
                      isLoading: isLoading,
                      onPressed: isLoading ? null : _onUpdatePressed,
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
