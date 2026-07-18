import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_state.freezed.dart';

@freezed
sealed class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState({
    BaseState<MessageEntity>? forgetPasswordState,
  }) = _ForgetPasswordState;

  factory ForgetPasswordState.initial() => ForgetPasswordState(
        forgetPasswordState: BaseState<MessageEntity>(),
      );
}
