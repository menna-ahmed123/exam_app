import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

Future<void> showExamTimeoutDialog(
  BuildContext context, {
  required VoidCallback onViewScore,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return ExamTimeoutDialog(
        onViewScore: () {
          Navigator.of(dialogContext).pop();
          onViewScore();
        },
      );
    },
  );
}

class ExamTimeoutDialog extends StatelessWidget {
  const ExamTimeoutDialog({super.key, required this.onViewScore});

  final VoidCallback onViewScore;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            timeoutHeader(),
            const SizedBox(height: 24),
            AppButton(text: AppStrings.viewScore, onPressed: onViewScore),
          ],
        ),
      ),
    );
  }

  Widget timeoutHeader() {
    return Row(
      children: [
        const Icon(
          Icons.hourglass_bottom,
          size: 40,
          color: AppPalette.primaryBlue,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            AppStrings.timeOutTitle,
            style: AppTextStyles.styleMedium20(color: AppPalette.error),
          ),
        ),
      ],
    );
  }
}
