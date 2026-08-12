import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';
import 'package:exam_app/feature/exam/presentation/explore/cubit/explore_cubit.dart';
import 'package:exam_app/feature/exam/presentation/explore/cubit/explore_event.dart';
import 'package:exam_app/feature/exam/presentation/explore/cubit/explore_state.dart';
import 'package:exam_app/feature/exam/presentation/explore/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExploreViewBody extends StatefulWidget {
  const ExploreViewBody({super.key});

  @override
  State<ExploreViewBody> createState() => ExploreViewBodyState();
}

class ExploreViewBodyState extends State<ExploreViewBody> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ExploreCubit>().onEvent(const ExploreEvent.loadSubjects());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _columnChildren(),
      ),
    );
  }

  List<Widget> _columnChildren() {
    return [
      const SizedBox(height: 12),
      Text(
        AppStrings.survey,
        style: AppTextStyles.styleSemiBold24(color: AppPalette.primaryBlue),
      ),
      const SizedBox(height: 16),
      _searchField(),
      const SizedBox(height: 24),
      Text(AppStrings.browseBySubject, style: AppTextStyles.styleMedium18()),
      const SizedBox(height: 12),
      Expanded(child: _subjectsConsumer()),
    ];
  }

  Widget _searchField() {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        context.read<ExploreCubit>().onEvent(ExploreEvent.searchChanged(value));
      },
      style: AppTextStyles.styleRegular16(),
      decoration: _searchDecoration(),
    );
  }

  InputDecoration _searchDecoration() {
    return InputDecoration(
      hintText: AppStrings.search,
      hintStyle: AppTextStyles.styleRegular16(color: AppPalette.hintText),
      prefixIcon: const Icon(Icons.search, color: AppPalette.hintText),
      filled: true,
      fillColor: AppPalette.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: _searchBorder(AppPalette.border),
      enabledBorder: _searchBorder(AppPalette.border),
      focusedBorder: _searchBorder(AppPalette.primaryBlue),
    );
  }

  OutlineInputBorder _searchBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _subjectsConsumer() {
    return BlocConsumer<ExploreCubit, ExploreState>(
      listener: _onExploreState,
      builder: (context, state) => _subjectsContent(context, state),
    );
  }

  void _onExploreState(BuildContext context, ExploreState state) {
    final error = state.subjectsState?.errorMessage ?? '';
    if (error.isEmpty) return;
    buildSnackBar(
      context: context,
      message: error,
      backgroundColor: AppPalette.error,
    );
  }

  Widget _subjectsContent(BuildContext context, ExploreState state) {
    final isLoading = state.subjectsState?.isLoading ?? false;
    final subjects = context.read<ExploreCubit>().filteredSubjects;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (subjects.isEmpty) {
      return Center(
        child: Text(
          AppStrings.noSubjectsFound,
          style: AppTextStyles.styleRegular16(color: AppPalette.grey),
        ),
      );
    }
    return _subjectsList(subjects);
  }

  Widget _subjectsList(List<SubjectEntity> subjects) {
    return ListView.separated(
      itemCount: subjects.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return SubjectCard(
          subject: subject,
          onTap: () => openSubjectExams(subject),
        );
      },
    );
  }

  void openSubjectExams(SubjectEntity subject) {
    context.push(AppRoutes.subjectExams, extra: subject);
  }
}
