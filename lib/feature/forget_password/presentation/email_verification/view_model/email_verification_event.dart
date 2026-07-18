sealed class EmailVerificationEvent {}

class MakeVerifyResetCode extends EmailVerificationEvent {
  final String resetCode;

  MakeVerifyResetCode({required this.resetCode});
}

class MakeResendCode extends EmailVerificationEvent {
  final String email;

  MakeResendCode({required this.email});
}
