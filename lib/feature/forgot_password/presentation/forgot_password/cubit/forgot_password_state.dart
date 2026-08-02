import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    BaseState<MessageEntity>? forgotPasswordState,
  }) = _ForgotPasswordState;

  factory ForgotPasswordState.initial() {
    return const ForgotPasswordState(
      forgotPasswordState: BaseState<MessageEntity>(),
    );
  }
}
