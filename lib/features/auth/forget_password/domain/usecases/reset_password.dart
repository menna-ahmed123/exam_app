import 'package:exam_app/core/error/failures.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);

  final ForgetPasswordRepository _repository;

  Future<({Failure? failure})> call({
    required String email,
    required String newPassword,
  }) {
    return _repository.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
