import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/core/storage/storage_keys.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/auth/data/models/login_response_model.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
final SecureStorageService secureStorageService;
  AuthRepoImpl({required this.authRemoteDataSource, required this.secureStorageService});
  @override
  Future<BaseResponse<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final BaseResponse<LoginResponseModel> loginResponseModel =
        await authRemoteDataSource.login(email: email, password: password);
   
   switch (loginResponseModel) {
     case SuccessResponse<LoginResponseModel>():
     final LoginResponseEntity loginResponseEntity =
    loginResponseModel.data.toDomain();
    await secureStorageService.write(
          key: StorageKeys.accessToken,
          value: loginResponseEntity.token,
        );


    return SuccessResponse<LoginResponseEntity>(loginResponseEntity);

    case ErrorResponse<LoginResponseModel>():
    return ErrorResponse<LoginResponseEntity>(
                errMessage: loginResponseModel.errMessage,

    ); 
      
   }
   
 
  }
}
