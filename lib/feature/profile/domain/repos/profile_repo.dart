import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_params.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';

abstract class ProfileRepo {
  Future<BaseResponse<ProfileEntity>> getProfile();

  Future<BaseResponse<ProfileEntity>> updateProfile({
    required UpdateProfileParams params,
  });
  Future<BaseResponse<ChangePasswordEntity>> changePassword(
    ChangePasswordParams params,
  );
}
