import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/auth/domain/entities/message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
sealed class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    BaseState<MessageEntity>? resetPasswordState,
  }) = _ResetPasswordState;

  factory ResetPasswordState.initial() => ResetPasswordState(
        resetPasswordState: BaseState<MessageEntity>(),
      );
}
