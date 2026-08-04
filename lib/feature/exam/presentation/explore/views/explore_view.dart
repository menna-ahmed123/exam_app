import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:exam_app/feature/exam/presentation/explore/widgets/explore_view_body.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_cubit.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_event.dart';
import 'package:exam_app/feature/exam/presentation/history/views/exam_history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => ExploreViewState();
}

class ExploreViewState extends State<ExploreView> {
  int currentIndex = 0;
  late final ExamHistoryCubit historyCubit = getIt<ExamHistoryCubit>();

  @override
  void dispose() {
    historyCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.scaffoldGrey,
      body: SafeArea(child: tabBody()),
      bottomNavigationBar: bottomNav(),
    );
  }

  Widget tabBody() {
    return IndexedStack(
      index: currentIndex,
      children: [
        const ExploreViewBody(),
        BlocProvider.value(
          value: historyCubit,
          child: const ExamHistoryView(),
        ),
        const ProfilePlaceholder(),
      ],
    );
  }

  Widget bottomNav() {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      indicatorColor: AppPalette.lightBlue,
      backgroundColor: AppPalette.white,
      destinations: destinations(),
    );
  }

  void onDestinationSelected(int index) {
    setState(() => currentIndex = index);
    if (index == 1) {
      historyCubit.onEvent(const ExamHistoryEvent.load());
    }
  }

  List<NavigationDestination> destinations() {
    return const [
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
    ];
  }
}

class ProfilePlaceholder extends StatelessWidget {
  const ProfilePlaceholder({super.key});

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
