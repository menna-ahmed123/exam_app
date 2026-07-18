import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/api/client/auth_api_client.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/models/forget_password_request_model.dart';
import 'package:exam_app/feature/auth/data/models/message_response_model.dart';
import 'package:exam_app/feature/auth/data/models/reset_password_request_model.dart';
import 'package:exam_app/feature/auth/data/models/verify_reset_code_request_model.dart';
import 'package:exam_app/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.authApiClient});

  final AuthApiClient authApiClient;

  @override
  Future<BaseResponse<MessageResponseModel>> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  }) async {
    try {
      final response = await authApiClient.forgetPassword(
        ForgetPasswordRequestModel.fromDomain(forgetPasswordEntity),
      );
      return SuccessResponse<MessageResponseModel>(response);
    } on Exception catch (e) {
      return ErrorResponse<MessageResponseModel>(error: e);
    }
  }

  @override
  Future<BaseResponse<MessageResponseModel>> verifyResetCode({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  }) async {
    try {
      final response = await authApiClient.verifyResetCode(
        VerifyResetCodeRequestModel.fromDomain(verifyResetCodeEntity),
      );
      return SuccessResponse<MessageResponseModel>(response);
    } on Exception catch (e) {
      return ErrorResponse<MessageResponseModel>(error: e);
    }
  }

  @override
  Future<BaseResponse<MessageResponseModel>> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  }) async {
    try {
      final response = await authApiClient.resetPassword(
        ResetPasswordRequestModel.fromDomain(resetPasswordEntity),
      );
      return SuccessResponse<MessageResponseModel>(response);
    } on Exception catch (e) {
      return ErrorResponse<MessageResponseModel>(error: e);
    }
  }
}
