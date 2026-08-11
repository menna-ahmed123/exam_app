import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/models/auth_response_model.dart';
import 'package:exam_app/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({
    required this.authRemoteDataSource,
    required this.secureStorageService,
  });

  final AuthRemoteDataSource authRemoteDataSource;
  final SecureStorageService secureStorageService;

  @override
  Future<BaseResponse<AuthResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final response = await authRemoteDataSource.login(
      email: email,
      password: password,
    );

    switch (response) {
      case SuccessResponse<AuthResponseModel>():
        final entity = response.data.toDomain();
        await secureStorageService.saveToken(entity.token);
        return SuccessResponse<AuthResponseEntity>(entity);

      case ErrorResponse<AuthResponseModel>():
        return ErrorResponse<AuthResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<AuthResponseEntity>> signUp({
    required SignUpEntity signUpEntity,
  }) async {
    final response = await authRemoteDataSource.signUp(
      signUpEntity: signUpEntity,
    );

    switch (response) {
      case SuccessResponse<AuthResponseModel>():
        final entity = response.data.toDomain();
        await secureStorageService.saveToken(entity.token!);
        return SuccessResponse(entity);

      case ErrorResponse<AuthResponseModel>():
        return ErrorResponse<AuthResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
