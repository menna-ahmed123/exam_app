import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/api/client/auth_api_client.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/models/login_request_model.dart';
import 'package:exam_app/feature/auth/data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient authApiClient;

  AuthRemoteDataSourceImpl({required this.authApiClient});
  @override
  Future<BaseResponse<LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      LoginResponseModel loginResponseModel = await authApiClient.login(
        LoginRequestModel(email: email, password: password),
      );
      return SuccessResponse<LoginResponseModel>(loginResponseModel);
    } on Exception catch (e) {
      return ErrorResponse<LoginResponseModel>(error: e);
    }
  }
}
