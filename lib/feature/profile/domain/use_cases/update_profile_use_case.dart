import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';
import 'package:exam_app/feature/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfileUseCase {
  final ProfileRepo profileRepo;

  UpdateProfileUseCase({required this.profileRepo});

  Future<BaseResponse<ProfileEntity>> call({
    required UpdateProfileParams params,
  }) {
    return profileRepo.updateProfile(params: params);
  }
}
