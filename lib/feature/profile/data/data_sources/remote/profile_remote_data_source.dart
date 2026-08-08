import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/data/models/change_password_request_model.dart';
import 'package:exam_app/feature/profile/data/models/change_password_response_model.dart';
import 'package:exam_app/feature/profile/data/models/profile_response_model.dart';

import 'package:exam_app/feature/profile/data/models/update_profile_request_model.dart';

abstract class ProfileRemoteDataSource {
  Future<BaseResponse<ProfileResponseModel>> getProfile();

  Future<BaseResponse<ProfileResponseModel>> updateProfile({
    required UpdateProfileRequestModel body,
  });

  Future<BaseResponse<ChangePasswordResponseModel>> changePassword({
    required ChangePasswordRequestModel body,
  });
}
