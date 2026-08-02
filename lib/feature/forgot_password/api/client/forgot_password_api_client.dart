import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/forgot_password/data/models/forgot_password_request_model.dart';
import 'package:exam_app/feature/forgot_password/data/models/message_response_model.dart';
import 'package:exam_app/feature/forgot_password/data/models/reset_password_request_model.dart';
import 'package:exam_app/feature/forgot_password/data/models/verify_reset_code_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'forgot_password_api_client.g.dart';

@RestApi()
abstract class ForgotPasswordApiClient {
  factory ForgotPasswordApiClient(Dio dio, {String baseUrl}) =
      _ForgotPasswordApiClient;

  @POST(ApiConstants.forgotPasswordEndpoint)
  Future<MessageResponseModel> forgotPassword(
    @Body() ForgotPasswordRequestModel request,
  );

  @POST(ApiConstants.verifyResetCodeEndpoint)
  Future<MessageResponseModel> verifyResetCode(
    @Body() VerifyResetCodeRequestModel request,
  );

  @PUT(ApiConstants.resetPasswordEndpoint)
  Future<MessageResponseModel> resetPassword(
    @Body() ResetPasswordRequestModel request,
  );
}
