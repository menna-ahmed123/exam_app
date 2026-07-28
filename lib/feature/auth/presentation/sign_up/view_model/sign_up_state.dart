import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState({BaseState<ResponseEntity>? signUpState}) =
      _SignUpState;

  factory SignUpState.initial() =>
      SignUpState(signUpState: BaseState<ResponseEntity>());
}
