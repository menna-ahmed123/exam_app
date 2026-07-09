class ResetPasswordRequest {
  const ResetPasswordRequest({
    required this.email,
    required this.newPassword,
  });

  final String email;
  final String newPassword;

  Map<String, dynamic> toJson() => {
        'email': email,
        'newPassword': newPassword,
      };
}
