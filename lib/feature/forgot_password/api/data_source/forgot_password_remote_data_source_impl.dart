import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/api/client/forgot_password_api_client.dart';
import 'package:exam_app/feature/forgot_password/data/data_sources/remote/forgot_password_remote_data_source.dart';
import 'package:exam_app/feature/forgot_password/data/models/forgot_password_request_model.dart';
import 'package:exam_app/feature/forgot_password/data/models/message_response_model.dart';
import 'package:exam_app/feature/forgot_password/data/models/reset_password_request_model.dart';
import 'package:exam_app/feature/forgot_password/data/models/verify_reset_code_request_model.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/forgot_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/verify_reset_code_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgotPasswordRemoteDataSource)
class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  ForgotPasswordRemoteDataSourceImpl({required this.forgotPasswordApiClient});

  final ForgotPasswordApiClient forgotPasswordApiClient;

  @override
  Future<BaseResponse<MessageResponseModel>> forgotPassword({
    required ForgotPasswordEntity forgotPasswordEntity,
  }) async {
    try {
      final response = await forgotPasswordApiClient.forgotPassword(
        ForgotPasswordRequestModel.fromDomain(forgotPasswordEntity),
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
      final response = await forgotPasswordApiClient.verifyResetCode(
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
      final response = await forgotPasswordApiClient.resetPassword(
        ResetPasswordRequestModel.fromDomain(resetPasswordEntity),
      );
      return SuccessResponse<MessageResponseModel>(response);
    } on Exception catch (e) {
      return ErrorResponse<MessageResponseModel>(error: e);
    }
  }
}
