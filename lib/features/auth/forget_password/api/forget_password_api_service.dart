import 'package:dio/dio.dart';
import 'package:exam_app/features/auth/forget_password/api/models/forgot_password_request.dart';
import 'package:exam_app/features/auth/forget_password/api/models/message_response.dart';
import 'package:exam_app/features/auth/forget_password/api/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/api/models/verify_reset_code_request.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_password_api_service.g.dart';

@RestApi()
abstract class ForgetPasswordApiService {
  factory ForgetPasswordApiService(Dio dio, {String baseUrl}) =
      _ForgetPasswordApiService;

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
