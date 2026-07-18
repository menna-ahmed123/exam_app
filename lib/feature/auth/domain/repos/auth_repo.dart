import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/message_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/verify_reset_code_entity.dart';

abstract class AuthRepo {
  Future<BaseResponse<MessageEntity>> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  });

  Future<BaseResponse<MessageEntity>> verifyResetCode({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  });

  Future<BaseResponse<MessageEntity>> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  });
}
