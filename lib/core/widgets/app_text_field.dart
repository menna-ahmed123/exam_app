import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.inputFormatters,
    this.autofillHints,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;
    final borderColor = hasError ? AppColors.error : AppColors.inputBorder;
    final labelColor = hasError ? AppColors.error : AppColors.grey;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          enabled: enabled,
          inputFormatters: inputFormatters,
          autofillHints: autofillHints,
          style: AppTextStyles.styleRegular16(color: AppColors.primaryText),
          decoration: InputDecoration(

            labelText: label,
            hintText: hint,
            errorText: hasError ? errorText : null,
              errorMaxLines: 2,
              errorStyle: const TextStyle(fontSize: 12),
             
            labelStyle: AppTextStyles.styleRegular13(color: labelColor),
            hintStyle: AppTextStyles.styleRegular16(color: AppColors.hintText),
            floatingLabelStyle: AppTextStyles.styleRegular13(color: labelColor),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            errorBorder: border,
            focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
            disabledBorder: border.copyWith(
              borderSide: BorderSide(color: AppColors.inputBorder.withValues(alpha: 0.4)),
            ),
          ),
        ),
      ],
    );
  }
}
