import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: _isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.primaryBlue,
          disabledForegroundColor: AppPalette.disabledButton,
          side: BorderSide(
            color: _isEnabled
                ? AppPalette.primaryBlue
                : AppPalette.disabledButton,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: AppTextStyles.styleMedium16(color: AppPalette.primaryBlue),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppPalette.primaryBlue,
                ),
              )
            : Text(text),
      ),
    );
  }
}
