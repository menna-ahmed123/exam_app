import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:flutter/material.dart';

class ExamHistoryCard extends StatelessWidget {
  const ExamHistoryCard({
    super.key,
    required this.entry,
    required this.onTap,
  });

  final ExamHistoryEntity entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppPalette.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      shadowColor: AppPalette.border,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: cardContent(),
      ),
    );
  }

  Widget cardContent() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          examImage(),
          const SizedBox(width: 12),
          Expanded(child: examDetails()),
        ],
      ),
    );
  }

  Widget examImage() {
    return Image.asset(
      'assets/images/app_icon.png',
      width: 56,
      height: 56,
      errorBuilder: (_, _, _) => const Icon(
        Icons.assignment_turned_in_outlined,
        size: 48,
        color: AppPalette.primaryBlue,
      ),
    );
  }

  Widget examDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleRow(),
        const SizedBox(height: 4),
        Text(
          '${entry.numberOfQuestions} ${AppStrings.question}',
          style: AppTextStyles.styleRegular14(color: AppPalette.grey),
        ),
        const SizedBox(height: 4),
        Text(
          '${entry.correct} ${AppStrings.correctedAnswersIn} ${entry.timeTakenMinutes} ${AppStrings.min}.',
          style: AppTextStyles.styleRegular14(color: AppPalette.primaryBlue),
        ),
      ],
    );
  }

  Widget titleRow() {
    return Row(
      children: [
        Expanded(
          child: Text(
            entry.examTitle,
            style: AppTextStyles.styleMedium16(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '${entry.durationMinutes} ${AppStrings.minutes}',
          style: AppTextStyles.styleRegular14(),
        ),
      ],
    );
  }
}
