import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/change_password_params.dart';
import 'package:exam_app/feature/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangePasswordUseCase {
  const ChangePasswordUseCase( {required this.profileRepo});

  final ProfileRepo profileRepo;

  Future<BaseResponse<ChangePasswordEntity>> call(ChangePasswordParams params) {
    return profileRepo.changePassword(params);
  }
}
