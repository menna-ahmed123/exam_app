import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AnswerOptionTile extends StatelessWidget {
  const AnswerOptionTile({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isMultiple,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final bool isMultiple;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppPalette.lightBlue : AppPalette.optionBackground,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(
                _icon,
                color: AppPalette.primaryBlue,
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
        ),
      ),
    );
  }

  IconData get _icon {
    if (isMultiple) {
      return isSelected ? Icons.check_box : Icons.check_box_outline_blank;
    }
    return isSelected ? Icons.radio_button_checked : Icons.radio_button_off;
  }
}
