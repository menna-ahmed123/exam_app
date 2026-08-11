import 'package:dio/dio.dart';
import 'package:exam_app/core/api/api_constants.dart';
import 'package:exam_app/feature/profile/data/models/change_password_request_model.dart';
import 'package:exam_app/feature/profile/data/models/change_password_response_model.dart';
import 'package:exam_app/feature/profile/data/models/profile_response_model.dart';
import 'package:exam_app/feature/profile/data/models/update_profile_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(ApiConstants.profileDataEndpoint)
  Future<ProfileResponseModel> getProfile();

  @PUT(ApiConstants.updateProfileEndpoint)
  Future<ProfileResponseModel> updateProfile({
    @Body() required UpdateProfileRequestModel body,
  });

  @PATCH(ApiConstants.changePasswordEndpoint)
  Future<ChangePasswordResponseModel> changePassword({
    @Body() required ChangePasswordRequestModel body,
  });
}
