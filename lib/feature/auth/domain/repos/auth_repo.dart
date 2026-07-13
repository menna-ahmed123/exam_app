import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';

abstract class AuthRepo {
  Future<BaseResponse<LoginResponseEntity>> login({
    required String email,
    required String password,
  });
}
