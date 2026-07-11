import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/features/auth/forget_password/data/models/forgot_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/message_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_request.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_password_api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ForgetPasswordApiClient {
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST('auth/forgotPassword')
  Future<MessageResponse> forgotPassword(
    @Body() ForgotPasswordRequest request,
  );

  @POST('auth/verifyResetCode')
  Future<MessageResponse> verifyResetCode(
    @Body() VerifyResetCodeRequest request,
  );

  @PUT('auth/resetPassword')
  Future<MessageResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}
