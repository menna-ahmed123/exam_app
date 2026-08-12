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

  static const List<String> instructions = [
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
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _backButton(context),
        const SizedBox(height: 20),
        _examHeader(),
        const SizedBox(height: 16),
        const Divider(color: AppPalette.border),
        const SizedBox(height: 16),
        Text(AppStrings.instructions, style: AppTextStyles.styleMedium18()),
        const SizedBox(height: 12),
        ...instructions.map(_instructionRow),
        const Spacer(),
        _startButton(context),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _startButton(BuildContext context) {
    return AppButton(
      text: AppStrings.start,
      onPressed: () => context.push(AppRoutes.takingExam, extra: args),
    );
  }

  Widget _backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: 20,
        color: AppPalette.primaryText,
      ),
    );
  }

  Widget _examHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerIcon(),
        const SizedBox(width: 12),
        Expanded(child: _headerTexts()),
      ],
    );
  }

  Widget _headerIcon() {
    return Image.asset(
      'assets/images/app_icon.png',
      width: 48,
      height: 48,
      errorBuilder: (_, _, _) => const Icon(
        Icons.quiz_outlined,
        size: 48,
        color: AppPalette.primaryBlue,
      ),
    );
  }

  Widget _headerTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subjectRow(),
        const SizedBox(height: 8),
        _examMetaRow(),
      ],
    );
  }

  Widget _subjectRow() {
    return Row(
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
          style: AppTextStyles.styleRegular14(color: AppPalette.primaryBlue),
        ),
      ],
    );
  }

  Widget _examMetaRow() {
    return Row(
      children: [
        Flexible(child: _examTitleText()),
        _metaDivider(),
        Text(
          '${args.numberOfQuestions} ${AppStrings.question}',
          style: AppTextStyles.styleRegular14(color: AppPalette.grey),
        ),
      ],
    );
  }

  Widget _examTitleText() {
    return Text(
      args.examTitle,
      style: AppTextStyles.styleMedium16(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _metaDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '|',
        style: AppTextStyles.styleRegular14(color: AppPalette.hintText),
      ),
    );
  }

  Widget _instructionRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bullet(),
          const SizedBox(width: 10),
          Expanded(child: _instructionText(text)),
        ],
      ),
    );
  }

  Widget _bullet() {
    return const Padding(
      padding: EdgeInsets.only(top: 6),
      child: Icon(Icons.circle, size: 6, color: AppPalette.grey),
    );
  }

  Widget _instructionText(String text) {
    return Text(
      text,
      style: AppTextStyles.styleRegular14(color: AppPalette.grey),
    );
  }
}
