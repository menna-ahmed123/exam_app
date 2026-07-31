import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/forget_password/data/models/forget_password_request_model.dart';
import 'package:exam_app/feature/forget_password/data/models/message_response_model.dart';
import 'package:exam_app/feature/forget_password/data/models/reset_password_request_model.dart';
import 'package:exam_app/feature/forget_password/data/models/verify_reset_code_request_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class ForgetPasswordApiClient {
  ForgetPasswordApiClient(this._dio);

  final Dio _dio;

  Future<MessageResponseModel> forgetPassword(
    ForgetPasswordRequestModel request,
  ) async {
    final response = await _dio.post(
      ApiConstants.forgetPasswordEndPoint,
      data: request.toJson(),
    );
    return MessageResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<MessageResponseModel> verifyResetCode(
    VerifyResetCodeRequestModel request,
  ) async {
    final response = await _dio.post(
      ApiConstants.verifyResetCodeEndPoint,
      data: request.toJson(),
    );
    return MessageResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<MessageResponseModel> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    final response = await _dio.put(
      ApiConstants.resetPasswordEndPoint,
      data: request.toJson(),
    );
    return MessageResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
