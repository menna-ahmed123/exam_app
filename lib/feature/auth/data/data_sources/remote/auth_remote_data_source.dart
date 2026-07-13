import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/data/models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<LoginResponseModel>> login (
     {
    required String email,
    required String password,
  });
}
