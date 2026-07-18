import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/auth/domain/entities/message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_state.freezed.dart';

@freezed
sealed class EmailVerificationState with _$EmailVerificationState {
  const factory EmailVerificationState({
    BaseState<MessageEntity>? emailVerificationState,
    BaseState<MessageEntity>? resendCodeState,
    @Default(0) int resetToken,
  }) = _EmailVerificationState;

  factory EmailVerificationState.initial() => EmailVerificationState(
        emailVerificationState: BaseState<MessageEntity>(),
        resendCodeState: BaseState<MessageEntity>(),
      );
}
