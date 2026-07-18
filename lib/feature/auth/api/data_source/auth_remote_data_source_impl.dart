import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/api/client/auth_api_client.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/models/login_request_model.dart';
import 'package:exam_app/feature/auth/data/models/auth_response_model.dart';
import 'package:exam_app/feature/auth/data/models/sign_up_request_model.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiClient authApiClient;

  AuthRemoteDataSourceImpl({required this.authApiClient});
  @override
  Future<BaseResponse<AuthResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponseModel loginResponseModel = await authApiClient.login(
        LoginRequestModel(email: email, password: password),
      );
      return SuccessResponse<AuthResponseModel>(loginResponseModel);
    } on Exception catch (e) {
      return ErrorResponse<AuthResponseModel>(error: e);
    }
  }

  @override
  Future<BaseResponse<AuthResponseModel>> signUp({
    required SignUpEntity signUpEntity,
  }) async {
    try {
      AuthResponseModel authResponseModel = await authApiClient.signUp(
        SignUpRequestModel(
          username: signUpEntity.username,
          firstName: signUpEntity.firstName,
          lastName: signUpEntity.lastName,
          email: signUpEntity.email,
          password: signUpEntity.password,
          rePassword: signUpEntity.rePassword,
          phone: signUpEntity.phone,
        ),
        
      );
      return SuccessResponse<AuthResponseModel>(authResponseModel);
    } on Exception catch (e) {
      return ErrorResponse<AuthResponseModel>(error: e);
    }
  }
}
