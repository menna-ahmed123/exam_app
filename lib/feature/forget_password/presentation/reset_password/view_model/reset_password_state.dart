import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';

class ResetPasswordState {
  const ResetPasswordState({this.resetPasswordState});

  final BaseState<MessageEntity>? resetPasswordState;

  factory ResetPasswordState.initial() {
    return ResetPasswordState(
      resetPasswordState: BaseState<MessageEntity>(),
    );
  }

  ResetPasswordState copyWith({
    BaseState<MessageEntity>? resetPasswordState,
  }) {
    return ResetPasswordState(
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }
}
