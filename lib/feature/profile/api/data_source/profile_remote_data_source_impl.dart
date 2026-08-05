import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/api/client/profile_api_client.dart';
import 'package:exam_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:exam_app/feature/profile/data/models/profile_response_model.dart';
import 'package:exam_app/feature/profile/data/models/update_profile_request_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient profileApiClient;

  ProfileRemoteDataSourceImpl({required this.profileApiClient});

  @override
  Future<BaseResponse<ProfileResponseModel>> getProfile() async {
    try {
      final ProfileResponseModel profileResponseModel = await profileApiClient
          .getProfile();
      return SuccessResponse<ProfileResponseModel>(profileResponseModel);
    } on Exception catch (e) {
      return ErrorResponse<ProfileResponseModel>(error: e);
    }
  }

  @override
  Future<BaseResponse<ProfileResponseModel>> updateProfile({
    required UpdateProfileRequestModel body,
  }) async {
    try {
      final ProfileResponseModel profileResponseModel = await profileApiClient
          .updateProfile(body: body);
      return SuccessResponse<ProfileResponseModel>(profileResponseModel);
    } on Exception catch (e) {
      return ErrorResponse<ProfileResponseModel>(error: e);
    }
  }
}
