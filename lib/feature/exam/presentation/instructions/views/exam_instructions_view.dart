import 'package:exam_app/core/constants/app_spacing.dart';
import 'package:exam_app/core/constants/app_strings.dart';
import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/core/routing/app_routes.dart';
import 'package:exam_app/core/widgets/app_button.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_session_args.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamInstructionsView extends StatelessWidget {
  const ExamInstructionsView({super.key, required this.args});

  final ExamSessionArgs args;

  static const List<String> _instructions = [
    AppStrings.instructionStableInternet,
    AppStrings.instructionDontLeave,
    AppStrings.instructionTimer,
    AppStrings.instructionSubmit,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: AppPalette.primaryText,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/app_icon.png',
                    width: 48,
                    height: 48,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.quiz_outlined,
                      size: 48,
                      color: AppPalette.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                args.subjectName,
                                style: AppTextStyles.styleMedium20(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${args.durationMinutes} ${AppStrings.minutes}',
                              style: AppTextStyles.styleRegular14(
                                color: AppPalette.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                args.examTitle,
                                style: AppTextStyles.styleMedium16(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '|',
                                style: AppTextStyles.styleRegular14(
                                  color: AppPalette.hintText,
                                ),
                              ),
                            ),
                            Text(
                              '${args.numberOfQuestions} ${AppStrings.question}',
                              style: AppTextStyles.styleRegular14(
                                color: AppPalette.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: AppPalette.border),
              const SizedBox(height: 16),
              Text(
                AppStrings.instructions,
                style: AppTextStyles.styleMedium18(),
              ),
              const SizedBox(height: 12),
              ..._instructions.map(
                (text) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                          color: AppPalette.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          text,
                          style: AppTextStyles.styleRegular14(
                            color: AppPalette.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                text: AppStrings.start,
                onPressed: () {
                  context.push(AppRoutes.takingExam, extra: args);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
