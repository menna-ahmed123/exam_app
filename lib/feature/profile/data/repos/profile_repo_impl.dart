import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:exam_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:exam_app/feature/profile/data/models/profile_response_model.dart';
import 'package:exam_app/feature/profile/data/models/update_profile_request_model.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';
import 'package:exam_app/feature/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl({required this.profileRemoteDataSource});

  @override
  Future<BaseResponse<ProfileEntity>> getProfile() async {
    final response = await profileRemoteDataSource.getProfile();
    switch (response) {
      case SuccessResponse<ProfileResponseModel>():
        final profileEntity = response.data.user.toDomain();
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
        final profileEntity = response.data.user.toDomain();
        return SuccessResponse(profileEntity);

      case ErrorResponse<ProfileResponseModel>():
        return ErrorResponse<ProfileEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
