import 'package:exam_app/core/error/failures.dart';
import 'package:exam_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repo);

  final ForgetPasswordRepo _repo;

  Future<({Failure? failure})> call({
    required String email,
    required String newPassword,
  }) {
    return _repo.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
