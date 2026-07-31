import 'package:exam_app/core/resources/app_palette.dart';
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
  });

  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String? errorText;

  @override
  State<OtpInputField> createState() => OtpInputFieldState();
}

class OtpInputFieldState extends State<OtpInputField> {
  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get code => controllers.map((c) => c.text).join();

  bool get hasError =>
      widget.errorText != null && widget.errorText!.isNotEmpty;

  void notifyChange() {
    final value = code;
    widget.onChanged?.call(value);
    if (value.length == widget.length) {
      widget.onCompleted?.call(value);
    }
  }

  void onChanged(int index, String value) {
    if (value.length > 1) {
      handlePaste(value, index);
      return;
    }
    if (value.isNotEmpty && index < widget.length - 1) {
      focusNodes[index + 1].requestFocus();
    }
    notifyChange();
  }

  void handlePaste(String value, int startIndex) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    for (var i = 0; i < digits.length && startIndex + i < widget.length; i++) {
      controllers[startIndex + i].text = digits[i];
    }
    final nextIndex = (startIndex + digits.length).clamp(0, widget.length - 1);
    focusNodes[nextIndex].requestFocus();
    notifyChange();
  }

  KeyEventResult onKeyEvent(int index, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.backspace &&
        controllers[index].text.isEmpty &&
        index > 0) {
      focusNodes[index - 1].requestFocus();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        OtpRow(
          length: widget.length,
          controllers: controllers,
          focusNodes: focusNodes,
          hasError: hasError,
          onChanged: onChanged,
          onKeyEvent: onKeyEvent,
        ),
        if (hasError) OtpErrorText(message: widget.errorText!),
      ],
    );
  }
}

class OtpRow extends StatelessWidget {
  const OtpRow({
    super.key,
    required this.length,
    required this.controllers,
    required this.focusNodes,
    required this.hasError,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final int length;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool hasError;
  final void Function(int index, String value) onChanged;
  final KeyEventResult Function(int index, KeyEvent event) onKeyEvent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Padding(
          padding: EdgeInsets.only(right: index < length - 1 ? 12 : 0),
          child: OtpBox(
            controller: controllers[index],
            focusNode: focusNodes[index],
            hasError: hasError,
            onChanged: (value) => onChanged(index, value),
            onKeyEvent: (event) => onKeyEvent(index, event),
          ),
        );
      }),
    );
  }
}

class OtpErrorText extends StatelessWidget {
  const OtpErrorText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 16, color: AppPalette.error),
          const SizedBox(width: 4),
          Text(
            message,
            style: AppTextStyles.styleRegular12().copyWith(
              color: AppPalette.error,
            ),
          ),
        ],
      ),
    );
  }
}

class OtpBox extends StatelessWidget {
  const OtpBox({
    super.key,
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
    return SizedBox(
      width: 56,
      height: 56,
      child: Focus(
        onKeyEvent: (node, event) => onKeyEvent(event),
        child: otpTextField(),
      ),
    );
  }

  Widget otpTextField() {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      style: AppTextStyles.styleMedium20().copyWith(
        color: AppPalette.primaryText,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      decoration: decoration(),
    );
  }

  InputDecoration decoration() {
    final borderColor = hasError ? AppPalette.error : AppPalette.transparent;
    return InputDecoration(
      counterText: '',
      filled: true,
      fillColor: AppPalette.lightBlue,
      contentPadding: EdgeInsets.zero,
      enabledBorder: boxBorder(borderColor),
      focusedBorder: boxBorder(
        hasError ? AppPalette.error : AppPalette.primaryBlue,
      ),
      errorBorder: boxBorder(AppPalette.error),
    );
  }

  OutlineInputBorder boxBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1.5),
    );
  }
}
