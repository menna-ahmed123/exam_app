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
  State<TakingExamView> createState() => TakingExamViewState();
}

class TakingExamViewState extends State<TakingExamView> {
  bool timeoutDialogShown = false;

  @override
  void initState() {
    super.initState();
    context.read<TakingExamCubit>().onEvent(
      TakingExamEvent.started(session: widget.args),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: onPopInvoked,
      child: BlocConsumer<TakingExamCubit, TakingExamState>(
        listener: onStateChanged,
        builder: (context, state) => examScaffold(context, state),
      ),
    );
  }

  Future<void> onPopInvoked(bool didPop, Object? _) async {
    if (didPop) return;
    final shouldExit = await confirmExit();
    if (shouldExit && mounted) context.pop();
  }

  Widget examScaffold(BuildContext context, TakingExamState state) {
    final questions = state.questionsState?.data ?? const <QuestionEntity>[];
    final isLoading = state.questionsState?.isLoading ?? false;
    final isSubmitting = state.submitState?.isLoading ?? false;
    return Scaffold(
      body: SafeArea(
        child: examBody(
          context: context,
          state: state,
          questions: questions,
          isLoading: isLoading,
          isSubmitting: isSubmitting,
        ),
      ),
    );
  }

  Widget examBody({
    required BuildContext context,
    required TakingExamState state,
    required List<QuestionEntity> questions,
    required bool isLoading,
    required bool isSubmitting,
  }) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (questions.isEmpty) return emptyQuestions();
    return ExamContent(
      state: state,
      questions: questions,
      isSubmitting: isSubmitting,
      onExitPressed: exitPressed,
    );
  }

  Widget emptyQuestions() {
    return Center(
      child: Text(
        AppStrings.noQuestionsFound,
        style: AppTextStyles.styleRegular16(color: AppPalette.grey),
      ),
    );
  }

  Future<void> exitPressed() async {
    final shouldExit = await confirmExit();
    if (shouldExit && mounted) context.pop();
  }

  Future<bool> confirmExit() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: exitDialog,
    );
    return shouldExit ?? false;
  }

  Widget exitDialog(BuildContext dialogContext) {
    return AlertDialog(
      title: Text(AppStrings.exitExamTitle, style: AppTextStyles.styleMedium18()),
      content: Text(
        AppStrings.exitExamMessage,
        style: AppTextStyles.styleRegular14(color: AppPalette.grey),
      ),
      actions: exitActions(dialogContext),
    );
  }

  List<Widget> exitActions(BuildContext dialogContext) {
    return [
      TextButton(
        onPressed: () => Navigator.of(dialogContext).pop(false),
        child: Text(
          AppStrings.cancel,
          style: AppTextStyles.styleMedium16(color: AppPalette.primaryBlue),
        ),
      ),
      TextButton(
        onPressed: () => Navigator.of(dialogContext).pop(true),
        child: Text(
          AppStrings.exit,
          style: AppTextStyles.styleMedium16(color: AppPalette.error),
        ),
      ),
    ];
  }

  void onStateChanged(BuildContext context, TakingExamState state) {
    showErrors(context, state);
    handleTimeout(context, state);
    navigateToScore(context, state);
  }

  void showErrors(BuildContext context, TakingExamState state) {
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
  }

  void handleTimeout(BuildContext context, TakingExamState state) {
    if (!state.isTimedOut || timeoutDialogShown) return;
    timeoutDialogShown = true;
    showExamTimeoutDialog(
      context,
      onViewScore: () {
        context.read<TakingExamCubit>().onEvent(
          const TakingExamEvent.viewScoreAfterTimeout(),
        );
      },
    );
  }

  void navigateToScore(BuildContext context, TakingExamState state) {
    final result = state.submitState?.data;
    if (!state.shouldNavigateToScore || result == null) return;
    final history = context.read<TakingExamCubit>().lastSavedHistory;
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
        historyId: history?.id ?? '',
        timeTakenMinutes: history?.timeTakenMinutes ?? 1,
        reviewQuestions: result.reviewQuestions,
      ),
    );
  }
}

class ExamContent extends StatelessWidget {
  const ExamContent({
    super.key,
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contentChildren(context),
      ),
    );
  }

  List<Widget> contentChildren(BuildContext context) {
    final question = questions[state.currentIndex];
    return [
      const SizedBox(height: 8),
      headerRow(),
      const SizedBox(height: 16),
      progressSection(),
      const SizedBox(height: 24),
      Text(question.question, style: AppTextStyles.styleMedium18()),
      const SizedBox(height: 16),
      Expanded(child: answersList(context, question)),
      navigationRow(context),
      const SizedBox(height: 24),
    ];
  }

  Widget headerRow() {
    final isLowTime = state.remainingSeconds <= (state.totalSeconds / 2);
    return Row(
      children: [
        backIcon(),
        const SizedBox(width: 4),
        Text(AppStrings.exam, style: AppTextStyles.styleMedium20()),
        const Spacer(),
        const Icon(Icons.alarm, size: 20, color: AppPalette.primaryBlue),
        const SizedBox(width: 4),
        timerText(isLowTime),
      ],
    );
  }

  Widget backIcon() {
    return GestureDetector(
      onTap: onExitPressed,
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: 20,
        color: AppPalette.primaryText,
      ),
    );
  }

  Widget timerText(bool isLowTime) {
    return Text(
      formatTime(state.remainingSeconds),
      style: AppTextStyles.styleMedium16(
        color: isLowTime ? AppPalette.error : AppPalette.timerGreen,
      ),
    );
  }

  Widget progressSection() {
    final progress = (state.currentIndex + 1) / questions.length;
    return Column(
      children: [
        questionCounter(),
        const SizedBox(height: 8),
        progressBar(progress),
      ],
    );
  }

  Widget questionCounter() {
    return Center(
      child: Text(
        '${AppStrings.questionOf} ${state.currentIndex + 1} ${AppStrings.of} ${questions.length}',
        style: AppTextStyles.styleRegular14(color: AppPalette.grey),
      ),
    );
  }

  Widget progressBar(double progress) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 4,
        backgroundColor: AppPalette.optionBackground,
        color: AppPalette.primaryBlue,
      ),
    );
  }

  Widget answersList(BuildContext context, QuestionEntity question) {
    final selectedKeys = state.selectedAnswers[question.id] ?? const <String>[];
    final isMultiple = question.type.toLowerCase().contains('multiple');
    return ListView.separated(
      itemCount: question.answers.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return answerTile(context, question, selectedKeys, isMultiple, index);
      },
    );
  }

  Widget answerTile(
    BuildContext context,
    QuestionEntity question,
    List<String> selectedKeys,
    bool isMultiple,
    int index,
  ) {
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
  }

  Widget navigationRow(BuildContext context) {
    final isLast = state.currentIndex == questions.length - 1;
    return Row(
      children: [
        Expanded(child: backButton(context)),
        const SizedBox(width: 12),
        Expanded(child: nextButton(context, isLast)),
      ],
    );
  }

  Widget backButton(BuildContext context) {
    return AppOutlinedButton(
      text: AppStrings.back,
      onPressed: state.currentIndex == 0
          ? null
          : () {
              context.read<TakingExamCubit>().onEvent(
                const TakingExamEvent.back(),
              );
            },
    );
  }

  Widget nextButton(BuildContext context, bool isLast) {
    return AppButton(
      text: isLast ? AppStrings.finish : AppStrings.next,
      isLoading: isSubmitting,
      onPressed: () => onNextOrFinish(context, isLast),
    );
  }

  void onNextOrFinish(BuildContext context, bool isLast) {
    final cubit = context.read<TakingExamCubit>();
    if (isLast) {
      cubit.onEvent(const TakingExamEvent.finish());
    } else {
      cubit.onEvent(const TakingExamEvent.next());
    }
  }

  String formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
