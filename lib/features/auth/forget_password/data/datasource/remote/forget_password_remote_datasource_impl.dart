import 'package:exam_app/features/auth/forget_password/api/datasource/remote/forget_password_api_datasource.dart';
import 'package:exam_app/features/auth/forget_password/data/datasource/remote/forget_password_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPasswordRemoteDatasource)
class ForgetPasswordRemoteDatasourceImpl
    implements ForgetPasswordRemoteDatasource {
  ForgetPasswordRemoteDatasourceImpl(this._apiDatasource);

  final ForgetPasswordApiDatasource _apiDatasource;

  @override
  Future<void> forgotPassword(String email) {
    return _apiDatasource.forgotPassword(email);
  }

  @override
  Future<void> verifyResetCode(String resetCode) {
    return _apiDatasource.verifyResetCode(resetCode);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return _apiDatasource.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
