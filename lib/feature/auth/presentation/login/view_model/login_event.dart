sealed class LoginEvent {}

class MakeLogin extends LoginEvent {
  final String email;
  final String password;

  MakeLogin({required this.email, required this.password});
}
