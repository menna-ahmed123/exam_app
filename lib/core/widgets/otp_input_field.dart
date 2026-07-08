import 'package:exam_app/core/resources/app_colors.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputField extends StatefulWidget {
  const OtpInputField({
    super.key,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
    this.errorText,
    this.controller,
  });

  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String? errorText;
  final TextEditingController? controller;

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _code => _controllers.map((c) => c.text).join();

  bool get _hasError =>
      widget.errorText != null && widget.errorText!.isNotEmpty;

  void _notifyChange() {
    final code = _code;
    widget.onChanged?.call(code);
    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      _handlePaste(value, index);
      return;
    }

    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    _notifyChange();
  }

  void _handlePaste(String value, int startIndex) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    for (var i = 0; i < digits.length && startIndex + i < widget.length; i++) {
      _controllers[startIndex + i].text = digits[i];
    }
    final nextIndex = (startIndex + digits.length).clamp(0, widget.length - 1);
    _focusNodes[nextIndex].requestFocus();
    _notifyChange();
  }

  KeyEventResult _onKeyEvent(int index, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                right: index < widget.length - 1 ? 12 : 0,
              ),
              child: _OtpBox(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                hasError: _hasError,
                onChanged: (value) => _onChanged(index, value),
                onKeyEvent: (event) => _onKeyEvent(index, event),
              ),
            );
          }),
        ),
        if (_hasError) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 16,
                color: AppColors.error,
              ),
              const SizedBox(width: 4),
              Text(
                widget.errorText!,
                style: AppTextStyles.styleRegular12().copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final ValueChanged<String> onChanged;
  final KeyEventResult Function(KeyEvent event) onKeyEvent;

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError ? AppColors.error : Colors.transparent;

    return SizedBox(
      width: 56,
      height: 56,
      child: Focus(
        onKeyEvent: (node, event) => onKeyEvent(event),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: AppTextStyles.styleMedium20().copyWith(
            color: AppColors.primaryText,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.lightBlue,
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? AppColors.error : AppColors.primaryBlue,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}
