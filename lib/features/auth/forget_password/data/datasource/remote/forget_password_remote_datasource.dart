abstract class ForgetPasswordRemoteDatasource {
  Future<void> forgotPassword(String email);

  Future<void> verifyResetCode(String resetCode);

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });
}
