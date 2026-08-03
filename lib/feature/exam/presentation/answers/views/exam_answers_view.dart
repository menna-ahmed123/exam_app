import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_answer_review_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/utils/answer_review_evaluator.dart';
import 'package:flutter/material.dart';

class ExamAnswersView extends StatelessWidget {
  const ExamAnswersView({super.key, required this.history});

  final ExamHistoryEntity history;

  @override
  Widget build(BuildContext context) {
    final questions = history.reviewQuestions;

    return Scaffold(
      backgroundColor: AppPalette.scaffoldGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                8,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: AppBackHeader(title: AppStrings.answers),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: questions.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.noExamHistory,
                        style: AppTextStyles.styleRegular16(
                          color: AppPalette.grey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontal,
                        vertical: 8,
                      ),
                      itemCount: questions.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return _AnswerReviewCard(question: questions[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerReviewCard extends StatelessWidget {
  const _AnswerReviewCard({required this.question});

  final ExamAnswerReviewEntity question;

  bool get _isMultiple => question.type.toLowerCase().contains('multiple');

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppPalette.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      shadowColor: AppPalette.border,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question,
              style: AppTextStyles.styleMedium16(),
            ),
            const SizedBox(height: 12),
            ...question.answers.map((option) {
              final state = AnswerReviewEvaluator.stateForOption(
                optionKey: option.key,
                selectedKeys: question.selectedKeys,
                correctKeys: question.correctKeys,
              );

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AnswerReviewOption(
                  text: option.answer,
                  isMultiple: _isMultiple,
                  isSelected: question.selectedKeys.any(
                    (key) =>
                        key.trim().toLowerCase() ==
                        option.key.trim().toLowerCase(),
                  ),
                  state: state,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _AnswerReviewOption extends StatelessWidget {
  const _AnswerReviewOption({
    required this.text,
    required this.isMultiple,
    required this.isSelected,
    required this.state,
  });

  final String text;
  final bool isMultiple;
  final bool isSelected;
  final AnswerOptionReviewState state;

  @override
  Widget build(BuildContext context) {
    final background = switch (state) {
      AnswerOptionReviewState.correct => AppPalette.correctBackground,
      AnswerOptionReviewState.incorrect => AppPalette.incorrectBackground,
      AnswerOptionReviewState.neutral => AppPalette.optionBackground,
    };
    final borderColor = switch (state) {
      AnswerOptionReviewState.correct => AppPalette.success,
      AnswerOptionReviewState.incorrect => AppPalette.error,
      AnswerOptionReviewState.neutral => AppPalette.transparent,
    };
    final iconColor = switch (state) {
      AnswerOptionReviewState.correct => AppPalette.success,
      AnswerOptionReviewState.incorrect => AppPalette.error,
      AnswerOptionReviewState.neutral => AppPalette.primaryBlue,
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(
            _iconFor(state),
            color: iconColor,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.styleRegular16(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(AnswerOptionReviewState state) {
    if (isMultiple) {
      return switch (state) {
        AnswerOptionReviewState.correct =>
          isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        AnswerOptionReviewState.incorrect => Icons.check_box,
        AnswerOptionReviewState.neutral => Icons.check_box_outline_blank,
      };
    }

    return switch (state) {
      AnswerOptionReviewState.correct =>
        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
      AnswerOptionReviewState.incorrect => Icons.radio_button_checked,
      AnswerOptionReviewState.neutral => Icons.radio_button_off,
    };
  }
}
