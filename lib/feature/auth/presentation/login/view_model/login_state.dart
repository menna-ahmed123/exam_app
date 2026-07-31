import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';

class LoginState {
  const LoginState({this.loginState});

  final BaseState<ResponseEntity>? loginState;

  factory LoginState.initial() {
    return LoginState(loginState: BaseState<ResponseEntity>());
  }

  LoginState copyWith({BaseState<ResponseEntity>? loginState}) {
    return LoginState(loginState: loginState ?? this.loginState);
  }
}
