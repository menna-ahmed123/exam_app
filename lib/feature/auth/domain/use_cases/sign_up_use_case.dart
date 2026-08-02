import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignUpUseCase {
  SignUpUseCase(this._authRepo);

  final AuthRepo _authRepo;

  Future<BaseResponse<AuthResponseEntity>> call({
    required SignUpEntity signUpEntity,
  }) {
    return _authRepo.signUp(signUpEntity: signUpEntity);
  }
}
