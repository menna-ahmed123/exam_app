import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/forgot_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/repos/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ForgotPasswordUseCase {
  ForgotPasswordUseCase(this._forgotPasswordRepo);

  final ForgotPasswordRepo _forgotPasswordRepo;

  Future<BaseResponse<MessageEntity>> call({
    required ForgotPasswordEntity forgotPasswordEntity,
  }) {
    return _forgotPasswordRepo.forgotPassword(
      forgotPasswordEntity: forgotPasswordEntity,
    );
  }
}
