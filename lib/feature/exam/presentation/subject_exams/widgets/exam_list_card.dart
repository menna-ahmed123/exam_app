import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';

class ExamListCard extends StatelessWidget {
  const ExamListCard({
    super.key,
    required this.exam,
    required this.onTap,
  });

  final ExamEntity exam;
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
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _examImage(),
          const SizedBox(width: 12),
          Expanded(child: _examDetails()),
        ],
      ),
    );
  }

  Widget _examImage() {
    return Image.asset(
      'assets/images/app_icon.png',
      width: 56,
      height: 56,
      errorBuilder: (_, _, _) => const Icon(
        Icons.quiz_outlined,
        size: 48,
        color: AppPalette.primaryBlue,
      ),
    );
  }

  Widget _examDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleRow(),
        const SizedBox(height: 4),
        Text(
          '${exam.numberOfQuestions} ${AppStrings.question}',
          style: AppTextStyles.styleRegular14(color: AppPalette.grey),
        ),
      ],
    );
  }

  Widget _titleRow() {
    return Row(
      children: [
        Expanded(
          child: Text(
            exam.title,
            style: AppTextStyles.styleMedium16(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '${exam.duration} ${AppStrings.minutes}',
          style: AppTextStyles.styleRegular14(color: AppPalette.primaryBlue),
        ),
      ],
    );
  }
}
