import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/auth/data/models/auth_response_model.dart';
import 'package:exam_app/feature/auth/data/models/login_request_model.dart';
import 'package:exam_app/feature/auth/data/models/sign_up_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST(ApiConstants.loginEndpoint)
  Future<AuthResponseModel> login(@Body() LoginRequestModel request);

  @POST(ApiConstants.signUpEndpoint)
  Future<AuthResponseModel> signUp(@Body() SignUpRequestModel request);
}
