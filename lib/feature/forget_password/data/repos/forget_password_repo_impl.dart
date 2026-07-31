import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forget_password/data/data_sources/remote/forget_password_remote_data_source.dart';
import 'package:exam_app/feature/forget_password/data/models/message_response_model.dart';
import 'package:exam_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:exam_app/feature/forget_password/domain/repos/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  ForgetPasswordRepoImpl({required this.forgetPasswordRemoteDataSource});

  final ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;

  @override
  Future<BaseResponse<MessageEntity>> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  }) async {
    final response = await forgetPasswordRemoteDataSource.forgetPassword(
      forgetPasswordEntity: forgetPasswordEntity,
    );

    switch (response) {
      case SuccessResponse<MessageResponseModel>():
        return SuccessResponse<MessageEntity>(response.data.toDomain());
      case ErrorResponse<MessageResponseModel>():
        return ErrorResponse<MessageEntity>(errMessage: response.errMessage);
    }
  }

  @override
  Future<BaseResponse<MessageEntity>> verifyResetCode({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  }) async {
    final response = await forgetPasswordRemoteDataSource.verifyResetCode(
      verifyResetCodeEntity: verifyResetCodeEntity,
    );

    switch (response) {
      case SuccessResponse<MessageResponseModel>():
        return SuccessResponse<MessageEntity>(response.data.toDomain());
      case ErrorResponse<MessageResponseModel>():
        return ErrorResponse<MessageEntity>(errMessage: response.errMessage);
    }
  }

  @override
  Future<BaseResponse<MessageEntity>> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  }) async {
    final response = await forgetPasswordRemoteDataSource.resetPassword(
      resetPasswordEntity: resetPasswordEntity,
    );

    switch (response) {
      case SuccessResponse<MessageResponseModel>():
        return SuccessResponse<MessageEntity>(response.data.toDomain());
      case ErrorResponse<MessageResponseModel>():
        return ErrorResponse<MessageEntity>(errMessage: response.errMessage);
    }
  }
}
