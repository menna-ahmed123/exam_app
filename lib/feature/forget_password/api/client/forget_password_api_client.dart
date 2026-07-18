import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/auth/data/models/forget_password_request_model.dart';
import 'package:exam_app/feature/auth/data/models/message_response_model.dart';
import 'package:exam_app/feature/auth/data/models/reset_password_request_model.dart';
import 'package:exam_app/feature/auth/data/models/verify_reset_code_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@singleton
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApiConstants.forgetPasswordEndPoint)
  Future<MessageResponseModel> forgetPassword(
    @Body() ForgetPasswordRequestModel request,
  );

  @POST(ApiConstants.verifyResetCodeEndPoint)
  Future<MessageResponseModel> verifyResetCode(
    @Body() VerifyResetCodeRequestModel request,
  );

  @PUT(ApiConstants.resetPasswordEndPoint)
  Future<MessageResponseModel> resetPassword(
    @Body() ResetPasswordRequestModel request,
  );
}
