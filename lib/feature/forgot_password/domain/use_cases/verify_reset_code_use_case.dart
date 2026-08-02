import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/verify_reset_code_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/repos/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class VerifyResetCodeUseCase {
  VerifyResetCodeUseCase(this._forgotPasswordRepo);

  final ForgotPasswordRepo _forgotPasswordRepo;

  Future<BaseResponse<MessageEntity>> call({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  }) {
    return _forgotPasswordRepo.verifyResetCode(
      verifyResetCodeEntity: verifyResetCodeEntity,
    );
  }
}
