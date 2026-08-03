import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_cubit.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_event.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_state.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/widgets/exam_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExamHistoryView extends StatefulWidget {
  const ExamHistoryView({super.key});

  @override
  State<ExamHistoryView> createState() => _ExamHistoryViewState();
}

class _ExamHistoryViewState extends State<ExamHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<ExamHistoryCubit>().onEvent(const ExamHistoryEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamHistoryCubit, ExamHistoryState>(
      listener: (context, state) {
        final error = state.historyState?.errorMessage ?? '';
        if (error.isNotEmpty) {
          buildSnackBar(
            context: context,
            message: error,
            backgroundColor: AppPalette.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.historyState?.isLoading ?? false;
        final grouped = context.read<ExamHistoryCubit>().groupedBySubject;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (grouped.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  AppStrings.results,
                  style: AppTextStyles.styleSemiBold24(),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    AppStrings.noExamHistory,
                    style: AppTextStyles.styleRegular16(color: AppPalette.grey),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        }

        final subjectNames = grouped.keys.toList();

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: subjectNames.length,
          itemBuilder: (context, index) {
            final subjectName = subjectNames[index];
            final entries = grouped[subjectName] ?? const <ExamHistoryEntity>[];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) ...[
                  Text(
                    AppStrings.results,
                    style: AppTextStyles.styleSemiBold24(),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  subjectName,
                  style: AppTextStyles.styleMedium18(),
                ),
                const SizedBox(height: 12),
                ...entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ExamHistoryCard(
                      entry: entry,
                      onTap: () {
                        context.push(
                          AppRoutes.examAnswers,
                          extra: entry,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        );
      },
    );
  }
}
