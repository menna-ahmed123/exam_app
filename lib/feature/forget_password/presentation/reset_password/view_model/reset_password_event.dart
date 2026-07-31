sealed class ResetPasswordEvent {}

class MakeResetPassword extends ResetPasswordEvent {
  final String email;
  final String newPassword;

  MakeResetPassword({
    required this.email,
    required this.newPassword,
  });
}
