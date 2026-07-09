import 'package:exam_app/core/error/failures.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forget_password_repository.dart';

class VerifyResetCodeUseCase {
  const VerifyResetCodeUseCase(this._repository);

  final ForgetPasswordRepository _repository;

  Future<({Failure? failure})> call(String resetCode) {
    return _repository.verifyResetCode(resetCode);
  }
}
