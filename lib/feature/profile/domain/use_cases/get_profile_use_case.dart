import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:exam_app/feature/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetProfileUseCase {
  final ProfileRepo profileRepo;

  GetProfileUseCase({required this.profileRepo});

  Future <BaseResponse<ProfileEntity>> call(){
     return profileRepo.getProfile();
  }
}
