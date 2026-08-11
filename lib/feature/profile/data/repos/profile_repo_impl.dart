import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/core/storage/secure_storage_service.dart';
import 'package:exam_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:exam_app/feature/profile/data/models/change_password_request_model.dart';
import 'package:exam_app/feature/profile/data/models/change_password_response_model.dart';
import 'package:exam_app/feature/profile/data/models/profile_response_model.dart';
import 'package:exam_app/feature/profile/data/models/update_profile_request_model.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_params.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';
import 'package:exam_app/feature/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  ProfileRepoImpl({
    required this.profileRemoteDataSource,
    required this.secureStorageService,
  });

  final ProfileRemoteDataSource profileRemoteDataSource;
  final SecureStorageService secureStorageService;

  @override
  Future<BaseResponse<ProfileEntity>> getProfile() async {
    final response = await profileRemoteDataSource.getProfile();

    switch (response) {
      case SuccessResponse<ProfileResponseModel>():
        final profileEntity = response.data.toDomain();
        return SuccessResponse(profileEntity);

      case ErrorResponse<ProfileResponseModel>():
        return ErrorResponse<ProfileEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<ProfileEntity>> updateProfile({
    required UpdateProfileParams params,
  }) async {
    final requestModel = UpdateProfileRequestModel.fromDomain(params);

    final response = await profileRemoteDataSource.updateProfile(
      body: requestModel,
    );

    switch (response) {
      case SuccessResponse<ProfileResponseModel>():
        final profileEntity = response.data.toDomain();
        return SuccessResponse(profileEntity);

      case ErrorResponse<ProfileResponseModel>():
        return ErrorResponse<ProfileEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword(
    ChangePasswordParams params,
  ) async {
    final requestModel = ChangePasswordRequestModel.fromDomain(params);

    final response = await profileRemoteDataSource.changePassword(
      body: requestModel,
    );

    switch (response) {
      case SuccessResponse<ChangePasswordResponseModel>():
        final entity = response.data.toDomain();

        await secureStorageService.saveToken(entity.token!);

        return SuccessResponse<ChangePasswordEntity>(entity);

      case ErrorResponse<ChangePasswordResponseModel>():
        return ErrorResponse<ChangePasswordEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
