import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forget_password/domain/repos/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ResetPasswordUseCase {
  ResetPasswordUseCase(this.forgetPasswordRepo);

  final ForgetPasswordRepo forgetPasswordRepo;

  Future<BaseResponse<MessageEntity>> call({
    required ResetPasswordEntity resetPasswordEntity,
  }) {
    return forgetPasswordRepo.resetPassword(
      resetPasswordEntity: resetPasswordEntity,
    );
  }
}
