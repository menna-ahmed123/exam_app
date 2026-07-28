import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppScreenHeader extends StatelessWidget {
  const AppScreenHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });

  final String title;
  final String? subtitle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: textAlign,
          style: AppTextStyles.styleSemiBold24(color: AppPalette.primaryText),
        ),
        if (subtitle != null) _Subtitle(text: subtitle!, textAlign: textAlign),
      ],
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.text, required this.textAlign});

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        text,
        textAlign: textAlign,
        style: AppTextStyles.styleRegular14().copyWith(color: AppPalette.grey),
      ),
    );
  }
}
