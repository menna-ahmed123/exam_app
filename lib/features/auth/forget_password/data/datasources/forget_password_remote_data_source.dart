import 'package:dio/dio.dart';
import 'package:exam_app/core/error/exceptions.dart';
import 'package:exam_app/features/auth/forget_password/api/forget_password_api_service.dart';
import 'package:exam_app/features/auth/forget_password/api/models/forgot_password_request.dart';
import 'package:exam_app/features/auth/forget_password/api/models/reset_password_request.dart';
import 'package:exam_app/features/auth/forget_password/api/models/verify_reset_code_request.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<void> forgotPassword(String email);

  Future<void> verifyResetCode(String resetCode);

  Future<void> resetPassword({
    required String email,
    required String newPassword,
  });
}

class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  ForgetPasswordRemoteDataSourceImpl(this._apiService);

  final ForgetPasswordApiService _apiService;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _apiService.forgotPassword(
        ForgotPasswordRequest(email: email),
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  @override
  Future<void> verifyResetCode(String resetCode) async {
    try {
      await _apiService.verifyResetCode(
        VerifyResetCodeRequest(resetCode: resetCode),
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      await _apiService.resetPassword(
        ResetPasswordRequest(email: email, newPassword: newPassword),
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  Exception _mapDioException(DioException error) {
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout) {
      return const NetworkException();
    }

    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      final message = data['message'] as String?;
      if (message != null && message.isNotEmpty) {
        return ServerException(message);
      }
    }

    return ServerException(
      error.message ?? 'Something went wrong. Please try again.',
    );
  }
}
