import 'package:exam_app/feature/forget_password/presentation/reset_password/widgets/reset_password_view_body.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResetPasswordViewBody(email: email),
    );
  }
}
