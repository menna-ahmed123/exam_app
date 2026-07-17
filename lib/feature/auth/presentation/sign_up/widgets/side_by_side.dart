import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class SideBySideFields extends StatelessWidget {
  const SideBySideFields({
    super.key,
    required this.leftLabel,
    required this.leftHint,
    required this.rightLabel,
    required this.rightHint,
    required this.onLeftChanged,
    required this.onRightChanged,
    this.rightValidator,
    this.leftValidator,
  });

  final String leftLabel;
  final String leftHint;
  final String rightLabel;
  final String rightHint;
  final ValueChanged<String> onLeftChanged;
  final ValueChanged<String> onRightChanged;
  final String? Function(String?)? rightValidator;
  final String? Function(String?)? leftValidator;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AppTextField(
              label: leftLabel,
              hint: leftHint,
              onChanged: onLeftChanged,
              validator: leftValidator,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppTextField(
              label: rightLabel,
              hint: rightHint,
              onChanged: onRightChanged,
              validator: rightValidator,
            ),
          ),
        ],
      )
    );
  }
}
