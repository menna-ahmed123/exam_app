import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
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
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText = widget.obscureText;

  bool get _hasError =>
      widget.errorText != null && widget.errorText!.isNotEmpty;

  Color get _borderColor =>
      _hasError ? AppPalette.error : AppPalette.inputBorder;

  Color get _labelColor => _hasError ? AppPalette.error : AppPalette.grey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      validator: widget.validator,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      style: AppTextStyles.styleRegular16(color: AppPalette.primaryText),
      decoration: _decoration(),
    );
  }

  OutlineInputBorder _border({double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: _borderColor, width: width),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      errorText: _hasError ? widget.errorText : null,
      errorMaxLines: 2,
      errorStyle: const TextStyle(fontSize: 12),
      labelStyle: AppTextStyles.styleRegular13(color: _labelColor),
      hintStyle: AppTextStyles.styleRegular16(color: AppPalette.hintText),
      floatingLabelStyle: AppTextStyles.styleRegular13(color: _labelColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: widget.obscureText ? _visibilityToggle() : null,
      enabledBorder: _border(),
      focusedBorder: _border(width: 1.5),
      errorBorder: _border(),
      focusedErrorBorder: _errorBorder(),
      disabledBorder: _disabledBorder(),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppPalette.error, width: 1.5),
    );
  }

  OutlineInputBorder _disabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: AppPalette.inputBorder.withValues(alpha: 0.4),
      ),
    );
  }

  Widget _visibilityToggle() {
    return IconButton(
      onPressed: () => setState(() => _obscureText = !_obscureText),
      icon: Icon(
        _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: AppPalette.grey,
      ),
    );
  }
}
