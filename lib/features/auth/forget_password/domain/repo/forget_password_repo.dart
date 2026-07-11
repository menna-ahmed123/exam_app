import 'package:exam_app/core/error/failures.dart';

abstract class ForgetPasswordRepo {
  Future<({Failure? failure})> forgotPassword(String email);

  Future<({Failure? failure})> verifyResetCode(String resetCode);

  Future<({Failure? failure})> resetPassword({
    required String email,
    required String newPassword,
  });
}
