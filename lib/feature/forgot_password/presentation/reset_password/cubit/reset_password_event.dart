import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_event.freezed.dart';

@freezed
sealed class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.submitted({
    required String email,
    required String newPassword,
  }) = ResetPasswordSubmitted;
}
