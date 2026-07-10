import 'package:exam_app/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class SideBySideFields extends StatelessWidget {
  const SideBySideFields({super.key, required this.leftLabel, required this.leftHint, required this.rightLabel, required this.rightHint, });

  final String leftLabel;
  final String leftHint;
  final String rightLabel;
  final String rightHint;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            label:leftLabel ,
            hint: leftHint,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppTextField(
              label: rightLabel, hint: rightHint,
          ),
        ),
      ],
    );
  }
}
