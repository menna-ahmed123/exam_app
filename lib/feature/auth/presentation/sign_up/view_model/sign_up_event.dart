import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';

sealed class SignUpEvent {
}

class MakeSignUp extends SignUpEvent {
   final SignUpEntity signUpEntity;

  MakeSignUp({required this.signUpEntity});
}