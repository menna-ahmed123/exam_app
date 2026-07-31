import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';

class ForgetPasswordState {
  const ForgetPasswordState({this.forgetPasswordState});

  final BaseState<MessageEntity>? forgetPasswordState;

  factory ForgetPasswordState.initial() {
    return ForgetPasswordState(
      forgetPasswordState: BaseState<MessageEntity>(),
    );
  }

  ForgetPasswordState copyWith({
    BaseState<MessageEntity>? forgetPasswordState,
  }) {
    return ForgetPasswordState(
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
    );
  }
}
