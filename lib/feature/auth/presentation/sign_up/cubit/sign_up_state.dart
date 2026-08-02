import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    BaseState<AuthResponseEntity>? signUpState,
  }) = _SignUpState;

  factory SignUpState.initial() {
    return SignUpState(signUpState: const BaseState<AuthResponseEntity>());
  }
}
