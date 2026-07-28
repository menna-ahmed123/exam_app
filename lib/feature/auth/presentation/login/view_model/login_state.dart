import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:exam_app/config/base_state/base_state.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({BaseState<ResponseEntity>? loginState}) =
      _LoginState;

  factory LoginState.initial() =>
      LoginState(loginState: BaseState<ResponseEntity>());
      
      
}
