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
  State<ExploreViewBody> createState() => _ExploreViewBodyState();
}

class _ExploreViewBodyState extends State<ExploreViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ExploreCubit>().onEvent(const ExploreEvent.loadSubjects());
  }

  @override
  void dispose() {
    _searchController.dispose();
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
        children: [
          const SizedBox(height: 12),
          Text(
            AppStrings.survey,
            style: AppTextStyles.styleSemiBold24(
              color: AppPalette.primaryBlue,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<ExploreCubit>().onEvent(
                ExploreEvent.searchChanged(value),
              );
            },
            style: AppTextStyles.styleRegular16(),
            decoration: InputDecoration(
              hintText: AppStrings.search,
              hintStyle: AppTextStyles.styleRegular16(
                color: AppPalette.hintText,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppPalette.hintText,
              ),
              filled: true,
              fillColor: AppPalette.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppPalette.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppPalette.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppPalette.primaryBlue),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.browseBySubject,
            style: AppTextStyles.styleMedium18(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocConsumer<ExploreCubit, ExploreState>(
              listener: (context, state) {
                final error = state.subjectsState?.errorMessage ?? '';
                if (error.isNotEmpty) {
                  buildSnackBar(
                    context: context,
                    message: error,
                    backgroundColor: AppPalette.error,
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state.subjectsState?.isLoading ?? false;
                final subjects = context.read<ExploreCubit>().filteredSubjects;

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (subjects.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noSubjectsFound,
                      style: AppTextStyles.styleRegular16(
                        color: AppPalette.grey,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: subjects.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return SubjectCard(
                      subject: subject,
                      onTap: () => _openSubjectExams(subject),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openSubjectExams(SubjectEntity subject) {
    context.push(AppRoutes.subjectExams, extra: subject);
  }
}
