import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/data/models/message_response_model.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/forgot_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/verify_reset_code_entity.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<BaseResponse<MessageResponseModel>> forgotPassword({
    required ForgotPasswordEntity forgotPasswordEntity,
  });

  Future<BaseResponse<MessageResponseModel>> verifyResetCode({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  });

  Future<BaseResponse<MessageResponseModel>> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  });
}
