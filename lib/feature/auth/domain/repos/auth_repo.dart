import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';

abstract class AuthRepo {
  Future<BaseResponse<ResponseEntity>> login({
    required String email,
    required String password,
  });
  
  Future<BaseResponse<ResponseEntity>> signUp({
    required SignUpEntity signUpEntity,
  });
  
}
