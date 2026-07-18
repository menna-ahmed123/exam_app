import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forget_password/api/client/forget_password_api_client.dart';
import 'package:exam_app/feature/forget_password/data/data_sources/remote/forget_password_remote_data_source.dart';
import 'package:exam_app/feature/forget_password/data/models/forget_password_request_model.dart';
import 'package:exam_app/feature/forget_password/data/models/message_response_model.dart';
import 'package:exam_app/feature/forget_password/data/models/reset_password_request_model.dart';
import 'package:exam_app/feature/forget_password/data/models/verify_reset_code_request_model.dart';
import 'package:exam_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl implements ForgetPasswordRemoteDataSource {
  ForgetPasswordRemoteDataSourceImpl({required this.forgetPasswordApiClient});

  final ForgetPasswordApiClient forgetPasswordApiClient;

  @override
  Future<BaseResponse<MessageResponseModel>> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  }) async {
    try {
      final response = await forgetPasswordApiClient.forgetPassword(
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
      final response = await forgetPasswordApiClient.verifyResetCode(
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
      final response = await forgetPasswordApiClient.resetPassword(
        ResetPasswordRequestModel.fromDomain(resetPasswordEntity),
      );
      return SuccessResponse<MessageResponseModel>(response);
    } on Exception catch (e) {
      return ErrorResponse<MessageResponseModel>(error: e);
    }
  }
}
