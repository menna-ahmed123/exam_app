import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/core/widgets/app_outlined_button.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_score_args.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_session_args.dart';
import 'package:exam_app/feature/exam/presentation/score/widgets/score_ring.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamScoreView extends StatelessWidget {
  const ExamScoreView({super.key, required this.args});

  final ExamScoreArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: scoreBody(context),
        ),
      ),
    );
  }

  Widget scoreBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        AppBackHeader(
          title: AppStrings.examScore,
          onBackPressed: () => context.go(AppRoutes.home),
        ),
        const SizedBox(height: 32),
        Text(AppStrings.yourScore, style: AppTextStyles.styleMedium18()),
        const SizedBox(height: 24),
        scoreSummary(),
        const Spacer(),
        ...actionButtons(context),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget scoreSummary() {
    return Row(
      children: [
        ScoreRing(percentage: args.percentage),
        const SizedBox(width: 32),
        scoreStatsColumn(),
      ],
    );
  }

  Widget scoreStatsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScoreStat(
          label: AppStrings.correct,
          value: args.correct,
          color: AppPalette.primaryBlue,
        ),
        const SizedBox(height: 16),
        ScoreStat(
          label: AppStrings.incorrect,
          value: args.wrong,
          color: AppPalette.error,
        ),
      ],
    );
  }

  List<Widget> actionButtons(BuildContext context) {
    return [
      AppButton(
        text: AppStrings.showResults,
        onPressed: () => context.go(AppRoutes.home),
      ),
      const SizedBox(height: 12),
      AppOutlinedButton(
        text: AppStrings.startAgain,
        onPressed: () => startAgain(context),
      ),
    ];
  }

  void startAgain(BuildContext context) {
    context.pushReplacement(
      AppRoutes.examInstructions,
      extra: ExamSessionArgs(
        examId: args.examId,
        examTitle: args.examTitle,
        subjectId: args.subjectId,
        subjectName: args.subjectName,
        durationMinutes: args.durationMinutes,
        numberOfQuestions: args.numberOfQuestions,
      ),
    );
  }
}

class ScoreStat extends StatelessWidget {
  const ScoreStat({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: AppTextStyles.styleMedium16(color: color)),
        const SizedBox(width: 12),
        scoreBadge(),
      ],
    );
  }

  Widget scoreBadge() {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: Text('$value', style: AppTextStyles.styleMedium16(color: color)),
    );
  }
}
