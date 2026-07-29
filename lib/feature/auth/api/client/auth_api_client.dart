import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/auth/data/models/auth_response_model.dart';
import 'package:exam_app/feature/auth/data/models/login_request_model.dart';
import 'package:exam_app/feature/auth/data/models/sign_up_request_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthApiClient {
  AuthApiClient(this._dio);

  final Dio _dio;

  Future<AuthResponseModel> login(LoginRequestModel request) async {
    final response = await _dio.post(
      ApiConstants.loginEndPoint,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<AuthResponseModel> signUp(SignUpRequestModel request) async {
    final response = await _dio.post(
      ApiConstants.signUpEndPoint,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
