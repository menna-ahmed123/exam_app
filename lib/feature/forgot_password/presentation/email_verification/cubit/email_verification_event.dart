import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_event.freezed.dart';

@freezed
sealed class EmailVerificationEvent with _$EmailVerificationEvent {
  const factory EmailVerificationEvent.verifySubmitted({
    required String resetCode,
  }) = VerifyResetCodeSubmitted;

  const factory EmailVerificationEvent.resendRequested({
    required String email,
  }) = ResendCodeRequested;
}
