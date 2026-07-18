import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/data/models/message_response_model.dart';
import 'package:exam_app/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/verify_reset_code_entity.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<MessageResponseModel>> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  });

  Future<BaseResponse<MessageResponseModel>> verifyResetCode({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  });

  Future<BaseResponse<MessageResponseModel>> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  });
}
