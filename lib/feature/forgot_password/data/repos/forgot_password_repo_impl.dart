import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/data/data_sources/remote/forgot_password_remote_data_source.dart';
import 'package:exam_app/feature/forgot_password/data/models/message_response_model.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/forgot_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/verify_reset_code_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/repos/forgot_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgotPasswordRepo)
class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  ForgotPasswordRepoImpl({required this.forgotPasswordRemoteDataSource});

  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  @override
  Future<BaseResponse<MessageEntity>> forgotPassword({
    required ForgotPasswordEntity forgotPasswordEntity,
  }) async {
    final response = await forgotPasswordRemoteDataSource.forgotPassword(
      forgotPasswordEntity: forgotPasswordEntity,
    );

    switch (response) {
      case SuccessResponse<MessageResponseModel>():
        return SuccessResponse<MessageEntity>(response.data.toDomain());
      case ErrorResponse<MessageResponseModel>():
        return ErrorResponse<MessageEntity>(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<MessageEntity>> verifyResetCode({
    required VerifyResetCodeEntity verifyResetCodeEntity,
  }) async {
    final response = await forgotPasswordRemoteDataSource.verifyResetCode(
      verifyResetCodeEntity: verifyResetCodeEntity,
    );

    switch (response) {
      case SuccessResponse<MessageResponseModel>():
        return SuccessResponse<MessageEntity>(response.data.toDomain());
      case ErrorResponse<MessageResponseModel>():
        return ErrorResponse<MessageEntity>(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<MessageEntity>> resetPassword({
    required ResetPasswordEntity resetPasswordEntity,
  }) async {
    final response = await forgotPasswordRemoteDataSource.resetPassword(
      resetPasswordEntity: resetPasswordEntity,
    );

    switch (response) {
      case SuccessResponse<MessageResponseModel>():
        return SuccessResponse<MessageEntity>(response.data.toDomain());
      case ErrorResponse<MessageResponseModel>():
        return ErrorResponse<MessageEntity>(errorMessage: response.errorMessage);
    }
  }
}
