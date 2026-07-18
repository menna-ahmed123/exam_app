import 'package:exam_app/feature/forget_password/presentation/email_verification/widgets/email_verification_view_body.dart';
import 'package:flutter/material.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmailVerificationViewBody(email: email),
    );
  }
}
