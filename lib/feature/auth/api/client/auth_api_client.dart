import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/auth/data/models/login_request_model.dart';
import 'package:exam_app/feature/auth/data/models/auth_response_model.dart';
import 'package:exam_app/feature/auth/data/models/sign_up_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';


@singleton
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApiConstants.loginEndPoint)
  Future<AuthResponseModel> login(
    @Body()
     LoginRequestModel request
     );
      @POST(ApiConstants.signUpEndPoint)
  Future<AuthResponseModel> signUp(
    @Body()
     SignUpRequestModel request);
}

