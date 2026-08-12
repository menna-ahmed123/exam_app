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
import 'package:exam_app/feature/exam/presentation/subject_exams/widgets/exam_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubjectExamsView extends StatefulWidget {
  const SubjectExamsView({super.key, required this.subject});

  final SubjectEntity subject;

  @override
  State<SubjectExamsView> createState() => SubjectExamsViewState();
}

class SubjectExamsViewState extends State<SubjectExamsView> {
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
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        AppBackHeader(title: widget.subject.name),
        const SizedBox(height: 20),
        Expanded(child: _examsConsumer()),
      ],
    );
  }

  Widget _examsConsumer() {
    return BlocConsumer<SubjectExamsCubit, SubjectExamsState>(
      listener: _onExamsState,
      builder: (context, state) => _examsContent(state),
    );
  }

  void _onExamsState(BuildContext context, SubjectExamsState state) {
    final error = state.examsState?.errorMessage ?? '';
    if (error.isEmpty) return;
    buildSnackBar(
      context: context,
      message: error,
      backgroundColor: AppPalette.error,
    );
  }

  Widget _examsContent(SubjectExamsState state) {
    final isLoading = state.examsState?.isLoading ?? false;
    final exams = state.examsState?.data ?? const <ExamEntity>[];
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (exams.isEmpty) {
      return Center(
        child: Text(
          AppStrings.noExamsFound,
          style: AppTextStyles.styleRegular16(color: AppPalette.grey),
        ),
      );
    }
    return _examsList(exams);
  }

  Widget _examsList(List<ExamEntity> exams) {
    return ListView.separated(
      itemCount: exams.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final exam = exams[index];
        return ExamListCard(
          exam: exam,
          onTap: () => openInstructions(exam),
        );
      },
    );
  }

  void openInstructions(ExamEntity exam) {
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
