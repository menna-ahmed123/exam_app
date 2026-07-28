import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LoginUseCase {
  LoginUseCase(this.loginRepo);

  final AuthRepo loginRepo;

  Future<BaseResponse<ResponseEntity>> call({
    required String email,
    required String password,
  }) async {
    final BaseResponse<ResponseEntity> loginResponseEntity = await loginRepo
        .login(email: email, password: password);

    return loginResponseEntity;
  }
 
}
