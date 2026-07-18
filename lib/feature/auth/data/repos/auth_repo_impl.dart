import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/models/message_response_model.dart';
import 'package:exam_app/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/message_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.authRemoteDataSource});

  final AuthRemoteDataSource authRemoteDataSource;

  @override
  Future<BaseResponse<MessageEntity>> forgetPassword({
    required ForgetPasswordEntity forgetPasswordEntity,
  }) async {
    final response = await authRemoteDataSource.forgetPassword(
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
    final response = await authRemoteDataSource.verifyResetCode(
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
    final response = await authRemoteDataSource.resetPassword(
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
