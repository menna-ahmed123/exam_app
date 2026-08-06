import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_event.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_view_model.dart';
import 'package:exam_app/feature/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(Menna):
    // Temporary implementation for Profile development.
    // Replace this with the actual HomeView and Bottom Navigation
    // after the Home feature is implemented.
    return BlocProvider(
create: (_) => getIt<ProfileViewModel>()..doEvent(GetProfileEvent()),
      child: const ProfileView(),
    );
  }

  // ===========================
  // Original HomeView
  // Uncomment this section after finishing the Profile feature.
  // ===========================

  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _homeAppBar(context),
      body: Center(
        child: Text(
          AppStrings.home,
          style: AppTextStyles.styleRegular16(
            color: AppPalette.primaryText,
          ),
        ),
      ),
    );
  }

  AppBar _homeAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.home,
        style: AppTextStyles.styleMedium20(
          color: AppPalette.primaryText,
        ),
      ),
      actions: [
        IconButton(
          tooltip: AppStrings.logout,
          onPressed: () => context.read<AuthCubit>().logout(),
          icon: const Icon(
            Icons.logout,
            color: AppPalette.primaryBlue,
          ),
        ),
      ],
    );
  }
  */
}
