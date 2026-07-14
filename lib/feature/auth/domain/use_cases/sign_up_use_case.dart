import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignUpUseCase {
  SignUpUseCase(this.signUpRepo);

  final AuthRepo signUpRepo;

  Future<BaseResponse<ResponseEntity>> call({
  required SignUpEntity signUpEntity
  }) async {
    final BaseResponse<ResponseEntity> signUpResponseEntity = await signUpRepo
        .signUp(signUpEntity: signUpEntity);

    return signUpResponseEntity;
  }
}
