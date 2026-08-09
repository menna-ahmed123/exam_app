
import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_event.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_state.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:exam_app/feature/profile/presentation/views/widgets/profile_avater.dart';
import 'package:exam_app/feature/profile/presentation/views/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => ProfileViewBodyState();
}

class ProfileViewBodyState extends State<ProfileViewBody> {
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().doEvent(GetProfileEvent());
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

  void _listener(BuildContext context, ProfileState state) {
    final profile = state.profileState.data;

    if (profile == null) return;

    _usernameController.text = profile.username;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _emailController.text = profile.email;
    _phoneController.text = profile.phone;
    _passwordController.text = '********';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
      listener: _listener,
      buildWhen: (previous, current) =>
          previous.profileState != current.profileState,
      builder: (context, state) => _buildBody(state),
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state.profileState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final errorMessage = state.profileState.errorMessage;

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(errorMessage),
      );
    }

    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
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
            _buildProfileForm(),
            const SizedBox(height: AppSpacing.buttonTopGap),
            _buildUpdateButton(context),
            const SizedBox(height: AppSpacing.sectionGap),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileForm() {
    return ProfileForm(
      enabled: false,
      usernameController: _usernameController,
      firstNameController: _firstNameController,
      lastNameController: _lastNameController,
      emailController: _emailController,
      passwordController: _passwordController,
      phoneController: _phoneController,
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return AppButton(
      text: AppStrings.update,
      onPressed: () {
        context.push(AppRoutes.profileEdit);
      },
    );
  }
}
