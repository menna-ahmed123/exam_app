import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/message_response.dart';

abstract class ForgetPasswordRepo {
  Future<BaseResponse<MessageResponse>> forgotPassword(String email);

  Future<BaseResponse<MessageResponse>> verifyResetCode(String resetCode);

  Future<BaseResponse<MessageResponse>> resetPassword({
    required String email,
    required String newPassword,
  });
}
