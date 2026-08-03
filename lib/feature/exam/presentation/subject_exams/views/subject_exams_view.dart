import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_session_args.dart';
import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_cubit.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_event.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_state.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/widgets/exam_history_card.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/widgets/exam_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubjectExamsView extends StatefulWidget {
  const SubjectExamsView({super.key, required this.subject});

  final SubjectEntity subject;

  @override
  State<SubjectExamsView> createState() => _SubjectExamsViewState();
}

class _SubjectExamsViewState extends State<SubjectExamsView> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectExamsCubit>().onEvent(
      SubjectExamsEvent.load(subjectId: widget.subject.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.scaffoldGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              AppBackHeader(title: widget.subject.name),
              const SizedBox(height: 20),
              Expanded(
                child: BlocConsumer<SubjectExamsCubit, SubjectExamsState>(
                  listener: (context, state) {
                    final error = state.examsState?.errorMessage ?? '';
                    if (error.isNotEmpty) {
                      buildSnackBar(
                        context: context,
                        message: error,
                        backgroundColor: AppPalette.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.examsState?.isLoading ?? false;
                    final exams = state.examsState?.data ?? const <ExamEntity>[];
                    final history = state.history;

                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (exams.isEmpty && history.isEmpty) {
                      return Center(
                        child: Text(
                          AppStrings.noExamsFound,
                          style: AppTextStyles.styleRegular16(
                            color: AppPalette.grey,
                          ),
                        ),
                      );
                    }

                    return ListView(
                      children: [
                        if (history.isNotEmpty) ...[
                          Text(
                            AppStrings.yourHistory,
                            style: AppTextStyles.styleMedium18(),
                          ),
                          const SizedBox(height: 12),
                          ...history.map(
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
                        if (exams.isNotEmpty) ...[
                          Text(
                            AppStrings.availableExams,
                            style: AppTextStyles.styleMedium18(),
                          ),
                          const SizedBox(height: 12),
                          ...exams.map(
                            (exam) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ExamListCard(
                                exam: exam,
                                onTap: () => _openInstructionsFromExam(exam),
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openInstructionsFromExam(ExamEntity exam) {
    context.push(
      AppRoutes.examInstructions,
      extra: ExamSessionArgs(
        examId: exam.id,
        examTitle: exam.title,
        subjectId: widget.subject.id,
        subjectName: widget.subject.name,
        durationMinutes: exam.duration,
        numberOfQuestions: exam.numberOfQuestions,
      ),
    );
  }
}
