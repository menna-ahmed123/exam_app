import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/api/datasource/remote/forget_password_api_datasource.dart';
import 'package:exam_app/features/auth/forget_password/data/models/message_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  ForgetPasswordRepoImpl(this._apiDatasource);

  final ForgetPasswordApiDatasource _apiDatasource;

  @override
  Future<BaseResponse<MessageResponse>> forgotPassword(String email) {
    return BaseResponse.execute(
      () => _apiDatasource.forgotPassword(email),
    );
  }

  @override
  Future<BaseResponse<MessageResponse>> verifyResetCode(String resetCode) {
    return BaseResponse.execute(
      () => _apiDatasource.verifyResetCode(resetCode),
    );
  }

  @override
  Future<BaseResponse<MessageResponse>> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return BaseResponse.execute(
      () => _apiDatasource.resetPassword(
        email: email,
        newPassword: newPassword,
      ),
    );
  }
}
