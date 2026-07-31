import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';

class EmailVerificationState {
  const EmailVerificationState({
    this.emailVerificationState,
    this.resendCodeState,
    this.resetToken = 0,
  });

  final BaseState<MessageEntity>? emailVerificationState;
  final BaseState<MessageEntity>? resendCodeState;
  final int resetToken;

  factory EmailVerificationState.initial() {
    return EmailVerificationState(
      emailVerificationState: BaseState<MessageEntity>(),
      resendCodeState: BaseState<MessageEntity>(),
    );
  }

  EmailVerificationState copyWith({
    BaseState<MessageEntity>? emailVerificationState,
    BaseState<MessageEntity>? resendCodeState,
    int? resetToken,
  }) {
    return EmailVerificationState(
      emailVerificationState:
          emailVerificationState ?? this.emailVerificationState,
      resendCodeState: resendCodeState ?? this.resendCodeState,
      resetToken: resetToken ?? this.resetToken,
    );
  }
}
