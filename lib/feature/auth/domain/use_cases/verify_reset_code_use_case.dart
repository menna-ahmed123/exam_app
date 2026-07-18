import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/message_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class VerifyResetCodeUseCase {
  VerifyResetCodeUseCase(this.authRepo);

  final AuthRepo authRepo;

  Future<BaseResponse<MessageEntity>> call({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  }) {
    return authRepo.verifyResetCode(
      verifyResetCodeEntity: verifyResetCodeEntity,
    );
  }
}
