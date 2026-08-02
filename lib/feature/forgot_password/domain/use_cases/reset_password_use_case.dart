import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/repos/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ResetPasswordUseCase {
  ResetPasswordUseCase(this._forgotPasswordRepo);

  final ForgotPasswordRepo _forgotPasswordRepo;

  Future<BaseResponse<MessageEntity>> call({
    required ResetPasswordEntity resetPasswordEntity,
  }) {
    return _forgotPasswordRepo.resetPassword(
      resetPasswordEntity: resetPasswordEntity,
    );
  }
}
