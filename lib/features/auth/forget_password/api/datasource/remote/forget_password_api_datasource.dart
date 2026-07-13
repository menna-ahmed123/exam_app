import 'package:exam_app/features/auth/forget_password/api/client/forget_password_api_client.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forgot_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/message_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_request.dart';
import 'package:injectable/injectable.dart';

abstract class ForgetPasswordApiDatasource {
  Future<MessageResponse> forgotPassword(String email);

  Future<MessageResponse> verifyResetCode(String resetCode);

  Future<MessageResponse> resetPassword({
    required String email,
    required String newPassword,
  });
}

@LazySingleton(as: ForgetPasswordApiDatasource)
class ForgetPasswordApiDatasourceImpl implements ForgetPasswordApiDatasource {
  ForgetPasswordApiDatasourceImpl(this._apiClient);

  final ForgetPasswordApiClient _apiClient;

  @override
  Future<MessageResponse> forgotPassword(String email) {
    return _apiClient.forgotPassword(ForgotPasswordRequest(email: email));
  }

  @override
  Future<MessageResponse> verifyResetCode(String resetCode) {
    return _apiClient.verifyResetCode(
      VerifyResetCodeRequest(resetCode: resetCode),
    );
  }

  @override
  Future<MessageResponse> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return _apiClient.resetPassword(
      ResetPasswordRequest(email: email, newPassword: newPassword),
    );
  }
}
