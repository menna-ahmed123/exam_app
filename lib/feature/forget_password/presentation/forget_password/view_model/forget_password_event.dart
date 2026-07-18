sealed class ForgetPasswordEvent {}

class MakeForgetPassword extends ForgetPasswordEvent {
  final String email;

  MakeForgetPassword({required this.email});
}
