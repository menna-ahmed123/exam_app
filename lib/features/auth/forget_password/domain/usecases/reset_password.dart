import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/message_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repo);

  final ForgetPasswordRepo _repo;

  Future<BaseResponse<MessageResponse>> call({
    required String email,
    required String newPassword,
  }) {
    return _repo.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
