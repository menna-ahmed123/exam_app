import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/exam/presentation/explore/widgets/explore_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.scaffoldGrey,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            ExploreViewBody(),
            _ResultPlaceholder(),
            _ProfilePlaceholder(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        indicatorColor: AppPalette.lightBlue,
        backgroundColor: AppPalette.white,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppPalette.primaryBlue),
            label: AppStrings.explore,
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment, color: AppPalette.primaryBlue),
            label: AppStrings.result,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppPalette.primaryBlue),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }
}

class _ResultPlaceholder extends StatelessWidget {
  const _ResultPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.noResultsYet,
        style: AppTextStyles.styleRegular16(color: AppPalette.grey),
      ),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () => context.read<AuthCubit>().logout(),
        icon: const Icon(Icons.logout, color: AppPalette.primaryBlue),
        label: Text(
          AppStrings.logout,
          style: AppTextStyles.styleMedium16(color: AppPalette.primaryBlue),
        ),
      ),
    );
  }
}
