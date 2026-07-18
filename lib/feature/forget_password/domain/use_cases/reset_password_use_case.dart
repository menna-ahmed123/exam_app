import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/message_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ResetPasswordUseCase {
  ResetPasswordUseCase(this.authRepo);

  final AuthRepo authRepo;

  Future<BaseResponse<MessageEntity>> call({
    required ResetPasswordEntity resetPasswordEntity,
  }) {
    return authRepo.resetPassword(
      resetPasswordEntity: resetPasswordEntity,
    );
  }
}
