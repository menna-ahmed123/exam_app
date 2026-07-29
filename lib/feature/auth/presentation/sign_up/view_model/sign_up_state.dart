import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';

class SignUpState {
  const SignUpState({this.signUpState});

  final BaseState<ResponseEntity>? signUpState;

  factory SignUpState.initial() {
    return SignUpState(signUpState: BaseState<ResponseEntity>());
  }

  SignUpState copyWith({BaseState<ResponseEntity>? signUpState}) {
    return SignUpState(signUpState: signUpState ?? this.signUpState);
  }
}
