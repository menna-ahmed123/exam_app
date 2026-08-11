import 'package:dio/dio.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/api/client/profile_api_client.dart';
import 'package:exam_app/feature/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:exam_app/feature/profile/data/models/change_password_request_model.dart';
import 'package:exam_app/feature/profile/data/models/change_password_response_model.dart';
import 'package:exam_app/feature/profile/data/models/profile_response_model.dart';
import 'package:exam_app/feature/profile/data/models/update_profile_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient profileApiClient;

  ProfileRemoteDataSourceImpl({required this.profileApiClient});

  @override
  Future<BaseResponse<ProfileResponseModel>> getProfile() async {
    try {
      final profileResponseModel = await profileApiClient.getProfile();

      return SuccessResponse<ProfileResponseModel>(profileResponseModel);
    } on DioException catch (e) {
      return ErrorResponse<ProfileResponseModel>(
        error: Exception(
          e.response?.data?['message'] ?? e.message ?? 'An error occurred',
        ),
      );
    } on Exception catch (e) {
      return ErrorResponse<ProfileResponseModel>(error: e);
    }
  }

  @override
  Future<BaseResponse<ProfileResponseModel>> updateProfile({
    required UpdateProfileRequestModel body,
  }) async {
    try {
      final profileResponseModel = await profileApiClient.updateProfile(
        body: body,
      );

      return SuccessResponse<ProfileResponseModel>(profileResponseModel);
    } on DioException catch (e) {
      return ErrorResponse<ProfileResponseModel>(
        error: Exception(
          e.response?.data?['message'] ?? e.message ?? 'An error occurred',
        ),
      );
    } on Exception catch (e) {
      return ErrorResponse<ProfileResponseModel>(error: e);
    }
  }

  @override
  Future<BaseResponse<ChangePasswordResponseModel>> changePassword({
    required ChangePasswordRequestModel body,
  }) async {
    try {
      final changePasswordResponseModel = await profileApiClient.changePassword(
        body: body,
      );

      return SuccessResponse<ChangePasswordResponseModel>(
        changePasswordResponseModel,
      );
    } on DioException catch (e) {
      return ErrorResponse<ChangePasswordResponseModel>(
        error: Exception(
          e.response?.data?['message'] ?? e.message ?? 'An error occurred',
        ),
      );
    } on Exception catch (e) {
      return ErrorResponse<ChangePasswordResponseModel>(error: e);
    }
  }
}
