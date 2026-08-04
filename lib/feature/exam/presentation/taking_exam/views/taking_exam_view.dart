import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/utils/build_snack_bar.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_outlined_button.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_score_args.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_session_args.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/cubit/taking_exam_cubit.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/cubit/taking_exam_event.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/cubit/taking_exam_state.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/widgets/answer_option_tile.dart';
import 'package:exam_app/feature/exam/presentation/taking_exam/widgets/exam_timeout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TakingExamView extends StatefulWidget {
  const TakingExamView({super.key, required this.args});

  final ExamSessionArgs args;

  @override
  State<TakingExamView> createState() => _TakingExamViewState();
}

class _TakingExamViewState extends State<TakingExamView> {
  bool _timeoutDialogShown = false;

  @override
  void initState() {
    super.initState();
    context.read<TakingExamCubit>().onEvent(
      TakingExamEvent.started(session: widget.args),
    );
  }

  Future<bool> _confirmExit() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            AppStrings.exitExamTitle,
            style: AppTextStyles.styleMedium18(),
          ),
          content: Text(
            AppStrings.exitExamMessage,
            style: AppTextStyles.styleRegular14(color: AppPalette.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                AppStrings.cancel,
                style: AppTextStyles.styleMedium16(
                  color: AppPalette.primaryBlue,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                AppStrings.exit,
                style: AppTextStyles.styleMedium16(color: AppPalette.error),
              ),
            ),
          ],
        );
      },
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldExit = await _confirmExit();
        if (shouldExit && context.mounted) {
          context.pop();
        }
      },
      child: BlocConsumer<TakingExamCubit, TakingExamState>(
        listener: _onStateChanged,
        builder: (context, state) {
          final questions =
              state.questionsState?.data ?? const <QuestionEntity>[];
          final isLoading = state.questionsState?.isLoading ?? false;
          final isSubmitting = state.submitState?.isLoading ?? false;

          return Scaffold(
            body: SafeArea(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : questions.isEmpty
                      ? Center(
                          child: Text(
                            AppStrings.noQuestionsFound,
                            style: AppTextStyles.styleRegular16(
                              color: AppPalette.grey,
                            ),
                          ),
                        )
                      : _ExamContent(
                          state: state,
                          questions: questions,
                          isSubmitting: isSubmitting,
                          onExitPressed: () async {
                            final shouldExit = await _confirmExit();
                            if (shouldExit && context.mounted) {
                              context.pop();
                            }
                          },
                        ),
            ),
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, TakingExamState state) {
    final error = state.questionsState?.errorMessage ?? '';
    if (error.isNotEmpty) {
      buildSnackBar(
        context: context,
        message: error,
        backgroundColor: AppPalette.error,
      );
    }
    final submitError = state.submitState?.errorMessage ?? '';
    if (submitError.isNotEmpty) {
      buildSnackBar(
        context: context,
        message: submitError,
        backgroundColor: AppPalette.error,
      );
    }

    if (state.isTimedOut && !_timeoutDialogShown) {
      _timeoutDialogShown = true;
      showExamTimeoutDialog(
        context,
        onViewScore: () {
          context.read<TakingExamCubit>().onEvent(
            const TakingExamEvent.viewScoreAfterTimeout(),
          );
        },
      );
    }

    final result = state.submitState?.data;
    if (state.shouldNavigateToScore && result != null) {
      context.pushReplacement(
        AppRoutes.examScore,
        extra: ExamScoreArgs(
          examId: widget.args.examId,
          examTitle: widget.args.examTitle,
          subjectId: widget.args.subjectId,
          subjectName: widget.args.subjectName,
          durationMinutes: widget.args.durationMinutes,
          numberOfQuestions: widget.args.numberOfQuestions,
          correct: result.correct,
          wrong: result.wrong,
          percentage: result.percentage,
        ),
      );
    }
  }
}

class _ExamContent extends StatelessWidget {
  const _ExamContent({
    required this.state,
    required this.questions,
    required this.isSubmitting,
    required this.onExitPressed,
  });

  final TakingExamState state;
  final List<QuestionEntity> questions;
  final bool isSubmitting;
  final VoidCallback onExitPressed;

  @override
  Widget build(BuildContext context) {
    final question = questions[state.currentIndex];
    final selectedKeys = state.selectedAnswers[question.id] ?? const <String>[];
    final isMultiple = question.type.toLowerCase().contains('multiple');
    final isLast = state.currentIndex == questions.length - 1;
    final progress = (state.currentIndex + 1) / questions.length;
    final isLowTime = state.remainingSeconds <= (state.totalSeconds / 2);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: onExitPressed,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: AppPalette.primaryText,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                AppStrings.exam,
                style: AppTextStyles.styleMedium20(),
              ),
              const Spacer(),
              const Icon(
                Icons.alarm,
                size: 20,
                color: AppPalette.primaryBlue,
              ),
              const SizedBox(width: 4),
              Text(
                _formatTime(state.remainingSeconds),
                style: AppTextStyles.styleMedium16(
                  color: isLowTime ? AppPalette.error : AppPalette.timerGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${AppStrings.questionOf} ${state.currentIndex + 1} ${AppStrings.of} ${questions.length}',
              style: AppTextStyles.styleRegular14(color: AppPalette.grey),
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: AppPalette.optionBackground,
              color: AppPalette.primaryBlue,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            question.question,
            style: AppTextStyles.styleMedium18(),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: question.answers.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = question.answers[index];
                return AnswerOptionTile(
                  text: option.answer,
                  isSelected: selectedKeys.contains(option.key),
                  isMultiple: isMultiple,
                  onTap: () {
                    context.read<TakingExamCubit>().onEvent(
                      TakingExamEvent.selectAnswer(option.key),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  text: AppStrings.back,
                  onPressed: state.currentIndex == 0
                      ? null
                      : () {
                          context.read<TakingExamCubit>().onEvent(
                            const TakingExamEvent.back(),
                          );
                        },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: isLast ? AppStrings.finish : AppStrings.next,
                  isLoading: isSubmitting,
                  onPressed: () {
                    final cubit = context.read<TakingExamCubit>();
                    if (isLast) {
                      cubit.onEvent(const TakingExamEvent.finish());
                    } else {
                      cubit.onEvent(const TakingExamEvent.next());
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
