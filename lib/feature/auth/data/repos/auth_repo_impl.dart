import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/core/storage/storage_keys.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/models/auth_response_model.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final SecureStorageService secureStorageService;
  AuthRepoImpl({
    required this.authRemoteDataSource,
    required this.secureStorageService,
  });
  @override
  Future<BaseResponse<ResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final BaseResponse<AuthResponseModel> loginResponseModel =
        await authRemoteDataSource.login(email: email, password: password);

    switch (loginResponseModel) {
      case SuccessResponse<AuthResponseModel>():
        final ResponseEntity loginResponseEntity = loginResponseModel.data
            .toDomain();
        await secureStorageService.write(
          key: StorageKeys.accessToken,
          value: loginResponseEntity.token,
        );

        return SuccessResponse<ResponseEntity>(loginResponseEntity);

      case ErrorResponse<AuthResponseModel>():
        return ErrorResponse<ResponseEntity>(
          errMessage: loginResponseModel.errMessage,
        );
    }
  }

  @override
  Future<BaseResponse<ResponseEntity>> signUp({
    required SignUpEntity signUpEntity,
  }) async {
    final BaseResponse<AuthResponseModel> signUpResponseModel =
        await authRemoteDataSource.signUp(signUpEntity: signUpEntity);

    switch (signUpResponseModel) {
      case SuccessResponse<AuthResponseModel>():
        final ResponseEntity signUpResponseEntity = signUpResponseModel.data
            .toDomain();
            await secureStorageService.write(
          key: StorageKeys.accessToken,
          value: signUpResponseEntity.token,
        );
        return SuccessResponse(signUpResponseEntity);
         case ErrorResponse<AuthResponseModel>():
        return ErrorResponse<ResponseEntity>(
          errMessage: signUpResponseModel.errMessage,
        );
    }
  }
}
