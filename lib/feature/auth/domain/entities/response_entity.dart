import 'package:exam_app/feature/auth/domain/entities/user_entity.dart';

class LoginResponseEntity {
  final String message;
  final String token;
  final UserEntity user;

  LoginResponseEntity({
    required this.message,
    required this.token,
    required this.user,
  });
}
